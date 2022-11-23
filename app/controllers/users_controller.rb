class UsersController < ApplicationController
  def index
  end

  def show
    @user = current_user
    @micropost = current_user.microposts.build
    @microposts = current_user.feed
  end

  def destroy
  end
end
