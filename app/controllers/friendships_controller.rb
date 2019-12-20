# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    # @friendship = current_user.friendships.build(friend_id: params[:requestee_user_id], status: false)
    # if @friendship.save
    #   redirect_to users_friends_path(current_user), notice: 'Friend request sent'
    # else
    #   redirect_to users_friends_path(current_user), alert: 'Something went wrong'
    # end
    if params.include?(:friend_id) #individual e.g. "Add friend" link
      @new_friendships = Friendship.create_friendship(current_user.id, params[:friend_id])
      redirect_to users_friends_path(current_user), notice: 'Friend request sent'
    else
      params[:user][:friend_ids].each do |f_id|
      @new_friendships = Friendship.create_friendship(current_use.id, f_id)
      redirect_to users_friends_path(current_user), alert: 'Something went wrong'
      end
    end
    # redirect_to users_path
  end

  def accept
    # if params[:requestee_user_id]
    #   requestee =  User.find(params[:requestee_user_id])
    #   requester = User.find(current_user.id)
    #   # requestee.confirm_friend(requester)
    #   f = Friendship.find_by(user_id: requestee.id, friend_id: requester.id)
    #   f.status = true
    #   f.save
    #   redirect_to user_friend_requests_path, notice: 'Friend confirmed'
    # else
    #   redirect_to user_friend_requests_path, alert: 'Something went wrong'
    # end
    if params[:requestee_user_id]
      Friendship.confirm_friendship(params[:requestee_user_id], params[:requested_user_id])
      redirect_to user_friend_requests_path, notice: 'Friend confirmed'
    else
      redirect_to user_friend_requests_path, alert: 'Something went wrong'
    end
      
  end

  # def delete
  #   @friendship = Friendship.find_by(user_id: params[:requester_user_id],
  #                                    friend_id: params[:requestee_user_id])
  #   if @friendship
  #     @friendship.destroy
  #     redirect_to user_friend_requests_path, notice: 'Friend removed'
  #   else
  #     redirect_to root_path, alert: 'You are not allowed to do this'
  #   end
  # end
  def delete
    if params[:requester_user_id]
      Friendship.delete_friendship(params[:requester_user_id],params[:requestee_user_id])
      redirect_to user_friend_requests_path, notice: 'Friend removed'
    else
      redirect_to root_path, alert: 'You are not allowed to do this'
    end
  end 
end
