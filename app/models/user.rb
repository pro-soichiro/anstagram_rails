class User < ApplicationRecord
  validates :last_name, presence: true
  validates :first_name, presence: true

  def full_name
    last_name + first_name
  end
end
