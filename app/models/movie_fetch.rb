class Movie_fetch
  include HTTParty

  base_uri "http://api.rottentomatoes.com/api/public/v1.0/"
  format :json
  @apikey = 'jysjncy27rvveb3ecuvw8v3a'

  def self.get_movies(movie_name)
    movies = get('/movies.json', :query => {'apikey' => @apikey, 'q' => movie_name})
    movies['movies']
  end

  def self.get_movie_by_id(movie_id)
    id = movie_id.to_s
    get("/movies/#{id}.json", :query => {'apikey' => @apikey})
  end

  def self.get_movie(movie_name, position=0)
    movie = Movie_fetch.get_movies(movie_name)
    movie[position]
  end

end
