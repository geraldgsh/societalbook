class Micropost < ApplicationRecord
  belongs_to :user
  validates :content, length: { maximum: 255 }, presence: true
end
