FactoryBot.define do
  factory :department do
    sequence(:name) { |n| "部署名#{n}" }
    description { '部署の説明' }
  end
end
