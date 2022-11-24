# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :comment_creator_right, only: :destroy
  before_action :find_comment, only: :destroy

  def index; end

  def show; end

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.create(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = 'Comment successfully created'
    else
      flash[:alert] = 'Comment can not be created'
    end
    redirect_to users_path(@micropost.user_id)
  end

  def edit; end

  def update; end

  def destroy
    @comment.destroy
    flash[:notice] = 'Comment deleted'
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:id, :content, :micropost_id, :user_id)
  end

  def logged_in_user
    if current_user.present?
      @comment = Micropost.find_by(id: params[:micropost_id])
    else
      flash[:alert] = 'You need to sign in for viewing, creating or changing ingestions'
      redirect_to sign_in_path
    end
  end

  def find_comment
    if Comment.exists?(params[:id])
      @comment = @micropost.comments.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def comment_creator
    return unless current_user.present? && @comment.present?

    current_user.id == @comment.user_id
  end

  def comment_creator_right
    return if comment_creator

    flash[:alert] = 'You need to be a creator for destroying comments'
    redirect_back(fallback_location: root_path)
  end
end
