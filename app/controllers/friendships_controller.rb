# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:requestee_user_id], status: false)
    if @friendship.save
      redirect_to users_friends_path(current_user), notice: 'Friend request sent'
    else
      redirect_to users_friends_path(current_user), alert: 'Something went wrong'
    end
  end

  def accept
    if params[:requestee_user_id]
      requestee =  User.find(params[:requestee_user_id])
      requester = User.find(current_user.id)
      # requestee.confirm_friend(requester)
      f = Friendship.find_by(user_id: requestee.id, friend_id: requester.id)
      f.status = true
      f.save
      redirect_to user_friend_requests_path, notice: 'Friend confirmed'
    else
      redirect_to user_friend_requests_path, alert: 'Something went wrong'
    end
  end

  def delete
    @friendship = Friendship.find_by(user_id: params[:requester_user_id],
                                     friend_id: params[:requestee_user_id])
    if @friendship
      @friendship.destroy
      redirect_to user_friend_requests_path, notice: 'Friend removed'
    else
      redirect_to root_path, alert: 'You are not allowed to do this'
    end
  end
end
