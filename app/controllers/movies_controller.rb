class MoviesController < ApplicationController
  before_action :require_signin, except: %i[index show]
  before_action :require_admin, except: %i[index show]
  before_action :set_movie, except: %i[index new]

  def index
    @movies = Movie.send(movies_filter)
  end

  def show
    # @movie = Movie.find(params[:id])
    @review = Review.new
    @fans = @movie.fans
    @favorite = current_user.favorites.find_by(movie_id: @movie.id) if current_user
    @genres = @movie.genres
  end

  def edit
    # @movie = Movie.find(params[:id])
  end

  def update
    # @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      flash[:notice] = 'Movie was successfully updated.'
      redirect_to @movie
      # same as redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      flash[:notice] = 'Movie was successfully created.'
      redirect_to @movie
    else
      render :new
    end
  end

  def destroy
    # @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_url, alert: 'Movie successfully deleted!'
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :description, :total_gross, :released_on, :rating, :director, :duration, :image_file_name, genre_ids: [])
  end

  def movies_filter
    if params[:filter].in? %w[upcoming recent hits flops]
      params[:filter]
    else
      :released
    end
  end
end
