module UsersHelper
  def show_username
    @user.username ? @user.username : "Username not set"
  end
end
