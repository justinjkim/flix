class ApplicationController < ActionController::Base
  private

  # these methods below are called by any controller
  def current_user?(user)
    user == current_user
  end

  def require_signin
    unless current_user
      session[:intended_url] = request.url # this saves intended URL before redirecting signed-out user to signin page
      redirect_to new_session_url, alert: "Please sign in first"
    end
  end

  def require_admin
    unless current_user_admin?
      redirect_to root_url, alert: "You must be an admin for this operation!"
    end
  end

  # moved this method to application_controller from application_helper, to make it available to controller
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user_admin?
    current_user && current_user.admin? ? true : false
  end

  helper_method :current_user
  helper_method :current_user?
end
