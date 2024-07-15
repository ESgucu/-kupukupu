class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    user.user = current_user
    user.save!
    # redirect_to user_path(user)
  end

  def user_params
    params.require(:user).permit(:name)
  end

end
