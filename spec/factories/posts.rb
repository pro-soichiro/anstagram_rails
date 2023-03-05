FactoryBot.define do
  factory :post do
    sequence(:caption) { |n| "キャプション#{n}" }
    image do
      Rack::Test::UploadedFile.new( \
        "#{Rails.root}/spec/files/attachment.jpg", 'image/jpeg'
      )
    end
    association :user
  end
end
