class MovieFetch
  include HTTParty

  base_uri "http://api.rottentomatoes.com/api/public/v1.0/"
  format :json
  @apikey = ENV["ROTTEN_API"]

  def self.movies(movie_name, limit=15)
    movies = get('/movies.json', :query => {'apikey' => @apikey, 'q' => movie_name, 'page_limit' => limit})
    return false if movies['movies'].blank?
    movielist = []
    movies['movies'].each { |movie| movielist << add_to_db(movie_parse(movie)) }
    movielist
  end

  def self.movie_by_id(movie_id)
    #returns "error" => "Movie not found" if id is wrong.
    movie = get("/movies/" + movie_id.to_s + ".json", :query => {'apikey' => @apikey})
    return false if movie['error']
    movie_parse(movie.parsed_response)
  end

  def self.movie_object(movie_name, options={limit: 1, position: 0})
    movies = get('/movies.json', :query => {'apikey' => @apikey, 'q' => movie_name, 'page_limit' => options[:limit]})
    return false if movies['movies'].blank?
    movies['movies'][options[:position]]
  end

  def self.movie(movie_name, options={position: 0, limit: 1})
    movie = movies(movie_name, options[:limit])
    return false unless movie
    movie[options[:position]]
  end

  private

    def self.movie_parse(movie)
      return false if movie['posters']['detailed'].include? 'poster_default.gif'
      synopsis = params_or_false(movie['synopsis']) || params_or_false(movie['critics_consensus'])
      return false unless synopsis
      {
        rotting_id:   movie['id'],
        title:        movie['title'],
        # for some reason many movies are missing synopsis..
        synopsis:     synopsis,
        runtime:      movie['runtime'],
        year:         movie['year'],
        # get the audience score ratings, not the critics..
        rating:       movie['ratings']['audience_score'],
        mpaa_rating:  movie['mpaa_rating'],
        thumb:        movie['posters']['detailed'],
        original:     movie['posters']['original']
      }
    end

    def self.params_or_false(param)
      param unless param.blank?
    end

    def self.add_to_db(movie)
      Movie.where(rotting_id: movie[:rotting_id]).first_or_create(movie) unless movie.blank?
    end
end
