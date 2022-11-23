class MicropostsController < ApplicationController

  before_action :logged_in_user
  before_action :micropost_creator_right, only: :destroy
  before_action :find_micropost, only: :destroy

  def index
  end

  def show
  end

  def new
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:notice] = 'Micropost successfully created'
      redirect_to root_path
    else
      flash[:alert] = 'Micropost can not be created'
      redirect_to root_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @micropost.destroy
    flash[:notice] = "Post deleted"
    redirect_back(fallback_location: root_path)
  end

  private

  def micropost_params
    params.require(:micropost).permit(:id, :content, :user_id, :created_at, :updated_at)
  end

  def logged_in_user
    if current_user.present?
      @micropost = current_user.microposts.find_by(id: params[:id])
    else
      flash[:alert] = "You need to sign in for viewing, creating or changing ingestions"
      redirect_to sign_in_path
    end
  end

  def find_micropost
    if Micropost.exists?(params[:id])
      @micropost = Micropost.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def micropost_creator
    if current_user.present? && @micropost.present?
      current_user.id == @micropost.user_id
    end
  end

  def micropost_creator_right
    unless micropost_creator
      flash[:alert] = "You need to be a creator for destroying microposts"
      redirect_back(fallback_location: root_path)
    end
  end

end
