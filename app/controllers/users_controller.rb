# frozen_string_literal: true

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

  def edit
  end

  def friends
    @user = User.find(params[:user_id])
    @friends = @user.friends
  end
end
