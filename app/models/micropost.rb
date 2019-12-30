# frozen_string_literal: true

class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  mount_uploader :picture, PictureUploader
  validates :content, length: { maximum: 255 }, presence: true
  validate :picture_size

  private

  # Validates the size of an uploaded picture.
  def picture_size
    errors.add(:picture, 'should be less than 5MB') if picture.size > 5.megabytes
  end
end
