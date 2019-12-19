class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => "User"
  validates :user, presence: true
  validates :friend, presence: true
  validates :status, presence: false
end
