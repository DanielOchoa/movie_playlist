class MoviesController < ApplicationController
  # GET /movies
  # GET /movies.json
  def index
    if params[:search].present?
      # call our MovieFetch first to pass search to DB...
      MovieFetch.movies(params[:search])
      @movies = Movie.text_search(params[:search])
    else
      @movies = Movie.limit(15)
    end

    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.json { render json: @movies }
    # end
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    @movie = Movie.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @movie }
    end
  end

  # GET /movies/new
  # GET /movies/new.json
  def new
    @movie = Movie.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @movie }
    end
  end

  # GET /movies/1/edit
  def edit
    @movie = Movie.find(params[:id])
  end

  # POST /movies
  # POST /movies.json
  def create
    #@movie = Movie.new(params[:movie])
    movie = MovieFetch.movie(params[:search]) unless params[:search].blank?
    # with return redirect_to, the rest of the code won't run.
    return redirect_to movies_path(:serach => params[:search]), notice: "No results found." unless movie

    localmovie = Movie.find_by_rotting_id(movie[:rotting_id])

    if localmovie.nil?
      @movie = Movie.new(movie)
      if @movie.save
        redirect_to movies_path(:search => params[:search]), notice: "Here's some movies!"
      else
        redirect_to movies_path, notice: @movie.errors.full_messages
      end
    else
      redirect_to movies_path(:search => params[:search]), notice: "Results:"
    end

    # respond_to do |format|
    #   if @movie.save
    #     format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
    #     format.json { render json: @movie, status: :created, location: @movie }
    #   else
    #     format.html { render action: "new" }
    #     format.json { render json: @movie.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PUT /movies/1
  # PUT /movies/1.json
  def update
    @movie = Movie.find(params[:id])

    respond_to do |format|
      if @movie.update_attributes(params[:movie])
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to movies_url }
      format.json { head :no_content }
    end
  end

end
