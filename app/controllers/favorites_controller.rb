class FavoritesController < ApplicationController
  before_action :require_signin # to make sure  that you have a user signed in
  def create
    @movie = Movie.find_by!(slug: params[:id])
    @movie.favorites.create!(user: current_user)
    # or append to the through association
    # @movie.fans << current_user
    redirect_to @movie
  end

  def destroy
    favorite = current_user.favorites.find(params[:id])
    favorite.destroy
    @movie = Movie.find_by!(slug: params[:id])
    redirect_to movie
  end
end
