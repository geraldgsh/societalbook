# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => "User"
  # validate :disallow_self_friendship
  validates_uniqueness_of :user, scope: [:user_id, :friend_id]
  validate :disallow_self_friendship
  
  def disallow_self_friendship
    if user_id == friend_id
      errors.add(:friend_id, "Can't friend yourself")
    end
  end

  def self.create_friendship(user_id, friend_id)
    user_friendship = Friendship.create(user_id: user_id, friend_id: friend_id, status: false)
    friend_friendship = Friendship.create(user_id: friend_id, friend_id: user_id, status: false)
    [user_friendship, friend_friendship]
  end

  def self.confirm_friendship(user_id, friend_id)
    friendship1 = Friendship.find_by(user_id: user_id, friend_id: friend_id)
    friendship2 = Friendship.find_by(user_id: friend_id, friend_id: user_id)
    friendship1.status = true
    friendship2.status = true
    friendship1.save
    friendship2.save
  end

  def self.delete_friendship(user_id, friend_id)
    friendship1 = Friendship.find_by(user_id: user_id, friend_id: friend_id)
    friendship2 = Friendship.find_by(user_id: friend_id, friend_id: user_id)
    friendship1.destroy
    friendship2.destroy
  end

end
