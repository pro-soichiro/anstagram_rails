# frozen_string_literal: true

class Prefecture < ApplicationRecord
  has_many :users

  validates :name, presence: true
end
