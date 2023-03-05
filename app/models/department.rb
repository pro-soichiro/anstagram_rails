# frozen_string_literal: true

class Department < ApplicationRecord
  has_and_belongs_to_many :users

  validates :name, presence: true
  validates :description, presence: true
end
