class Like < ApplicationRecord
  belongs_to :micropost
  belongs_to :user

  validates :user_id, uniqueness: { scope: :micropost_id }
end
