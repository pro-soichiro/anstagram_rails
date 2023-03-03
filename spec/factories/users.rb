FactoryBot.define do
  factory :user do
    last_name { '間宮' }
    first_name { '漱一朗' }
    sequence(:email) { |n| "soichiro#{n}@gmail.com" }
    password { 'password1234' }
  end

  trait :with_posts do
    after(:create) { |user| create_list(:post, 3, user: user) }
  end

  trait :with_likes_posts do
    after(:create) { |user| create_list(:like, 3, user: user) }
  end
end
