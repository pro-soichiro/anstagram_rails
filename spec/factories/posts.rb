FactoryBot.define do
  factory :post do
    sequence(:caption) { |n| "キャプション#{n}" }
    image {
      Rack::Test::UploadedFile.new( \
        "#{Rails.root}/spec/files/attachment.jpg", 'image/jpeg')
    }
    association :user
  end
end
