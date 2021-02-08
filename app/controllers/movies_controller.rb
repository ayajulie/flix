class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new

    respond_to do |format|
      if @movie.save
        flash[:notice] = 'Movie was successfully created.'
        format.html { redirect_to(@movie) }

      else
        format.html { render action: 'new' }
      end
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update(movie_params)
    redirect_to @movie
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :total_gross, :released_on, :rating)
  end
end
