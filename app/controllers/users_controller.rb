class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @users = User.all
    if params[:id].nil?
      @user = current_user
    else
      @user = User.find(params[:id])
    end
    @micropost = @user.microposts.build
    @microposts = @user.feed
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:id, :email)
  end

end
