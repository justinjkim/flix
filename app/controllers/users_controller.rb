class UsersController < ApplicationController

  before_action :require_signin, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
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
    @user.destroy
    session[:user_id] = nil # need this line, otherwise app raises an exception when you delete an account, because we deleted the :user_id key, reference current_user method
    redirect_to movies_url, alert: "Account was deleted!"
  end

  private

  def require_correct_user
    @user = User.find(params[:id]) # this @user gets called for edit, update, destroy actions
    unless current_user == @user
      redirect_to movies_url # redirect if user is not signed in
    end
  end

  def user_params
    params.require(:user)
          .permit(:name, :email, :username, :password, :password_confirmation)
  end
end
