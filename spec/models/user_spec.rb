require 'rails_helper'

RSpec.describe User, type: :model do
  it "姓、名、メール、パスワードがあれば有効な状態であること" do
    user = User.new(
      last_name: '間宮',
      first_name: '漱一朗',
      email: 'soichiro@gmail.com',
      password: 'password1234'
    )
    expect(user).to be_valid
  end

  it "名がなければ無効な状態であること" do
    user = User.new(first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("は必須項目です")
  end

  it "姓がなければ無効な状態であること" do
    user = User.new(last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("は必須項目です")
  end

  it "メールアドレスがなければ無効な状態であること" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("は必須項目です")
  end

  it "重複したメールアドレスなら無効な状態であること" do
    User.create(
      last_name: '間宮',
      first_name: '漱一朗',
      email: 'soichiro@gmail.com',
      password: 'password1234'
    )
    user = User.new(
      last_name: '間宮',
      first_name: '漱一朗',
      email: 'soichiro@gmail.com',
      password: 'password1234'
    )
    user.skip_confirmation!
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end

  it "ユーザーのフルネームを文字列として返すこと" do
    user = User.new(
      last_name: '間宮',
      first_name: '漱一朗'
    )
    expect(user.full_name).to eq('間宮 漱一朗')
  end

end
