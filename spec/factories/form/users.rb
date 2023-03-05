FactoryBot.define do
  factory :form_user, class: Form::User do
    last_name { '間宮' }
    first_name { '漱一朗' }
    last_name_kana { 'まみや' }
    first_name_kana { 'そういちろう' }
    departments { [''] }
  end
end
