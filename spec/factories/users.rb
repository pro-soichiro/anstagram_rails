FactoryBot.define do
  factory :user do
    last_name { '間宮' }
    first_name { '漱一朗' }
    sequence(:email) { |n| "soichiro#{n}@gmail.com" }
    password { 'password1234' }
  end
end
