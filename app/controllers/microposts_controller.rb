class MicropostsController < ApplicationController
  before_action :find_post, except: [:new, :create, :index]
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

	def index
    @posts = Micropost.all
		@post = Micropost.new
		@comments = Comment.all
		@comment = Comment.new
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
    puts "#$$$$$$$$$$$$$$ #{current_user}"
		@post = current_user.microposts.create(content: params[:micropost][:content])
		redirect_to microposts_url
		# render json: @post
	end

	def destroy
		@post.destroy
		redirect_to root_path
	end

	def find_post
		@post = Micropost.find(params[:id])
	end
end
