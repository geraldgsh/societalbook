# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => "User"
  validates_uniqueness_of :user, scope: [:user_id, :friend_id]
  validate :disallow_self_friendship
  validate :duplicate_check
  
  def disallow_self_friendship
    if user_id == friend_id
      errors.add(:friend_id, "Can't friend yourself")
    end
  end

  def duplicate_check
    if Friendship.where(user_id: user_id.id, friend_id: friend_id.id).empty? && Friendship.where(user_id: user_id.id, friend_id: friend_id.id).empty?
      errors.add(:base, "Friendship exist")
    end
  end
end
