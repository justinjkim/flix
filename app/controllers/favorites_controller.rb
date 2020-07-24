class FavoritesController < ApplicationController
  before_action :require_signin
  before_action :set_movie

  def create
    @movie.favorites.create!(user: current_user)
    # an alternative to the above line is:
    # @movie.fans << current_user

    redirect_to @movie # you need the redirect to refresh the page with the new count
  end

  def destroy
    @favorite = current_user.favorites.find(params[:id])
    @favorite.destroy

    redirect_to movie_path(@movie)
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
