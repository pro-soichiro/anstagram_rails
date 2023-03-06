# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    sequence(:caption) { |n| "キャプション#{n}" }
    image do
      Rack::Test::UploadedFile.new( \
        Rails.root.join('spec/files/attachment.jpg'), 'image/jpeg'
      )
    end
    association :user
  end
end
