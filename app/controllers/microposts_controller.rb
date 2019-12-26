# frozen_string_literal: true

class MicropostsController < ApplicationController
  before_action :find_post, except: %i[new create index]
  before_action :authenticate_user!, only: %i[new create edit update destroy]

  def index
    @posts = Micropost.all
    @feeds = current_user.feed
    @post = Micropost.new
    @comments = Comment.all
    @comment = Comment.new
    @likes = Like.all
  end

  def show
  end

  def edit
  end

  def update
    @post.update(content: params[:post][:content])

    redirect_to @post
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'Micropost created!'
      redirect_to microposts_url
    else
      flash[:error] = 'Micropost created!'
      render root_url
    end
  end

  def destroy
    @post.destroy
    redirect_to microposts_path
  end

  def find_post
    @post = Micropost.find(params[:id])
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :picture)
  end
end
