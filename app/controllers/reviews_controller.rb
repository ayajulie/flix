class ReviewsController < ApplicationController
  before_action :set_movie
  def index
    @reviews = @movie.reviews
  end

  def new
    @review = @movie.reviews.new
  end

  def create
    @review = @movie.reviews.new(review_params)

    if @review.save
      redirect_to movie_reviews_path(@movie),
                  notice: 'Thanks for your review!'
    else
      render :new
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  # def edit
  #   @review = Review.find(params[:id])
  #   # @movie = @review.movie
  # end

  # def update
  #   @review = Review.find(params[:id])

  #   if @review.update(review_params)
  #     flash[:success] = 'Object was successfully updated'
  #     redirect_to @review
  #   else
  #     flash[:error] = 'Something went wrong'
  #     render :edit
  #   end
  # end

  private

  def review_params
    params.require(:review).permit(:name, :comment, :stars)
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
