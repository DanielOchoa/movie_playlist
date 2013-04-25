class Movie_fetch
  include HTTParty

  base_uri "http://api.rottentomatoes.com/api/public/v1.0/"
  format :json
  @apikey = ENV["ROTTEN_API"]

  def self.movies(movie_name, limit=15)
    movies = get('/movies.json', :query => {'apikey' => @apikey, 'q' => movie_name, 'page_limit' => limit})
    movies['movies']
  end

  def self.movie_by_id(movie_id)
    get("/movies/" + movie_id.to_s + ".json", :query => {'apikey' => @apikey})
  end

  def self.movie_object(movie_name, options={limit: 1, position: 0})
    movie = Movie_fetch.movies(movie_name, options[:limit])
    movie[options[:position]]
  end

  # dont change options....
  def self.movie(movie_name, options={limit: 1, position: 0})
    movie = Movie_fetch.movies(movie_name, options[:limit])
    return false if movie.blank?
    movie = movie[options[:position]]
    newmovie = {
      rotting_id:   movie['id'],
      title:        movie['title'],
      # for some reason many movies are missing synopsys..
      synopsis:     movie['synopsys'].blank? ? movie['critics_consensus'] : movie['synopsys'],
      runtime:      movie['runtime'],
      year:         movie['year'],
      rating:       movie['ratings']['audience_score'],
      mpaa_rating:  movie['mpaa_rating'],
      thumb:        movie['posters']['detailed'],
      original:     movie['posters']['original']
    }
    newmovie
  end

end
