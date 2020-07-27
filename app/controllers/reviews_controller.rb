class ReviewsController < ApplicationController

  before_action :require_signin
  before_action :set_movie

  def index
    @reviews = @movie.reviews
  end

  def new
    @review = @movie.reviews.new
  end

  def create
    @review = @movie.reviews.new(review_params)
    @review.user = current_user # associate current_user to review before saving; require_signin makes sure current_user exists

    @review.update(review_params)
    if @review.save
      redirect_to movie_reviews_url(@movie), notice: "Thank you for your review!"
    else
      render "new"
    end
  end

  private

  def set_movie
    @movie = Movie.find_by!(slug: params[:movie_id])
  end

  def review_params
    params.require(:review).permit(:stars, :comment)
  end
end
