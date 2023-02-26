class Post < ApplicationRecord
  validates :caption, presence: true
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :likes_users, through: :likes, source: :user
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [300, 300]
  end
end
