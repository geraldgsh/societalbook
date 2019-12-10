class Micropost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :content, length: { maximum: 255 }, presence: true
end
