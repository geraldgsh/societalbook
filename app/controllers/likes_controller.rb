class LikesController < ApplicationController
  before_action :find_post
  before_action :find_like, only: [:destroy]
  
  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @post.likes.create(user_id: current_user.id)
    end
    redirect_to microposts_path
  end

  def destroy
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
    end
    redirect_to microposts_path
  end

  private

  def find_post
    @post = Micropost.find(params[:micropost_id])
  end

  def find_like
    @like = @post.likes.find(params[:id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, micropost_id:
    params[:micropost_id]).exists?
  end
end