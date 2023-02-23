class Post < ApplicationRecord
  validates :caption, presence: true
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :likes_users, through: :likes, source: :user
end
