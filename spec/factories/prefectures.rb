# frozen_string_literal: true

FactoryBot.define do
  factory :prefecture do
    sequence(:name) { |n| "都道府県名#{n}" }
  end
end
