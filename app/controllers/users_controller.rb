class UsersController < ApplicationController
  def show

  end

  def index
    @users = User.all
  end

  def friend_requests
    @user = current_user
    @friend_requests = @user.pending_friends
  end

  # def confirm
  #   puts "user: #{:user}"
  #   # @current_user =  current_user
  #   # user.confirm_friend(@current_user.id)
  #   # redirect_to users_path
  # end

  def edit
  end

  def friends
    @user = User.find(params[:user_id])
    @friends = @user.friends
    # puts "This is #{@friends}"
  end
end
