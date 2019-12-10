class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validate :replay, presence: true, length: { maximum: 255 }
end
