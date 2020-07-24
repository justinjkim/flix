class FavoritesController < ApplicationController
  before_action :require_signin

  def create
    @movie = Movie.find(params[:movie_id])
    @movie.favorites.create!(user: current_user)
    # an alternative to the above line is:
    # @movie.fans << current_user

    redirect_to @movie # you need the redirect to refresh the page with the new count
  end
end
