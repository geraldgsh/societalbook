class UsersController < ApplicationController
  def show
  end

  def edit
  end

  def friends
    @user = User.find(params[:user_id])
    @friends = @user.friends
    # puts "This is #{@friends}"
  end
end
