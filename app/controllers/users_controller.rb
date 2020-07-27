class UsersController < ApplicationController

  before_save :lowercase

  before_action :require_signin, except: [:new, :create] # require_signin defined in application_controller
  before_action :require_correct_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.non_admin
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: "Account was created!"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @favorite_movies = @user.favorite_movies
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: "Account was successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id]) # need this line, since "before_action :require_correct_user" doesn't run for this anymore
    @user.destroy
    session[:user_id] = nil # need this line, otherwise app raises an exception when you delete an account, because we deleted the :user_id key, reference current_user method
    redirect_to root_url, alert: "Account was deleted!"
  end

  private

  def require_correct_user
    @user = User.find(params[:id]) # this @user gets called for [:edit, :update] actions
    redirect_to movies_url unless current_user?(@user)
  end

  def user_params
    params.require(:user)
          .permit(:name, :email, :username, :password, :password_confirmation)
  end

  def lowercase
    self.username = username.downcase # must use "self" because we're writing to this object
    self.email = email.downcase
  end
end
