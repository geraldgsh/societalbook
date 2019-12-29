# frozen_string_literal: true

class UsersController < ApplicationController

  def show
    @user = User.find(params[:user_id])
    @pagy, @friends = pagy(@user.friends, items: 3) 
  end

  def index
    @users = User.all
    @pagy, @nofriends = pagy(User.all_except(current_user), page: params[:page], items: 9)
  end

  def friend_requests
    @user = current_user
    @friend_requests = @user.pending_friends
  end

  def edit
  end

  def friends
    @user = User.find(params[:user_id])
    # @friends = @user.friends
    @pagy_a, @friends = pagy_array(@user.friends, items: 9)
  end
end
