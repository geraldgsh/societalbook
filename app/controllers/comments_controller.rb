# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy]
  before_action :authenticate_user!

  def create
    @post = Micropost.find(params[:comment][:micropost_id])
    @comments = @post.comments
    @comment = @post.comments.build(comment_params)
    if @comment.save
      redirect_back(fallback_location: microposts_path)
    else
      flash[:alert] = 'Check the comment form'
      redirect_to root_path
    end
  end

  def destroy
    @comment.destroy
    redirect_to microposts_path
  end

  def edit; end

  def update; end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :micropost_id, :replay)
  end

  def set_post
    @comment = Comment.find(params[:id])
  end
end
