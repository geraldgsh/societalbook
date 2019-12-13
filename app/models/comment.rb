# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :replay, presence: true, length: { maximum: 255 }
end
