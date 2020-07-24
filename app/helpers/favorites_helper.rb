module FavoritesHelper
  # you can use ERB syntax without using the actual tags themselves
  def fave_or_unfave_button(movie, favorite) # view helpers should not rely on instance variables being set
    if favorite
      button_to "♡ Unfave", movie_favorite_path(movie, favorite), method: :delete
    else
      button_to "♥️ Fave", movie_favorites_path(movie) # you need to pass in movie because route has :movie_id placeholder
    end
  end
end
