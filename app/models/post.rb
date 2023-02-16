class Post < ApplicationRecord
  include Visible

  validates :caption, presence: true
  belongs_to :user
end
