class ReviewsController < ApplicationController
  before_action :set_slug
  before_action :require_signin
  def index
    @reviews = @movie.reviews.order('created_at DESC')
  end

  def new
    @review = @movie.reviews.new
  end

  def create
    @review = @movie.reviews.new(review_params)
    @review.user = current_user
    # @review.movie = @movie

    if @review.save
      redirect_to movie_reviews_path(@movie),
                  notice: 'Thanks for your review!'
    else
      render :new
      # render 'movies/show'
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  private

  def review_params
    params.require(:review).permit(:comment, :stars)
  end

  def set_slug
    @movie = Movie.find_by!(slug: params[:id])
  end
  # def set_movie
  #   @movie = Movie.find(params[:movie_id])
  # end
end
