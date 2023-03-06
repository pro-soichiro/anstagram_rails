# frozen_string_literal: true

class Prefecture < ApplicationRecord
  has_many :user, dependent: :restrict_with_errors

  validates :name, presence: true
end
