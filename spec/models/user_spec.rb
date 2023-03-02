require 'rails_helper'

RSpec.describe User, type: :model do
  it "姓、名、メール、パスワードがあれば有効な状態であること" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "名がなければ無効な状態であること" do
    user = FactoryBot.build(:user, first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("は必須項目です")
  end

  it "姓がなければ無効な状態であること" do
    user = FactoryBot.build(:user, last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("は必須項目です")
  end

  it "メールアドレスがなければ無効な状態であること" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("は必須項目です")
  end

  it "重複したメールアドレスなら無効な状態であること" do
    FactoryBot.create(:user, email: 'soichiro@gmail.com')
    user = FactoryBot.build(:user, email: 'soichiro@gmail.com')
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end

  it "ユーザーのフルネームを文字列として返すこと" do
    user = FactoryBot.build(:user, last_name: '間宮', first_name: '漱一朗')
    expect(user.full_name).to eq('間宮 漱一朗')
  end

  it "ユーザーのフルネームのかなを文字列として返すこと" do
    user = FactoryBot.build(:user,
      last_name_kana: 'まみや',
      first_name_kana: 'そういちろう'
    )
    expect(user.full_name_kana).to eq('まみや そういちろう')
  end

  it "画像の拡張子にはpng.jpg,jpegが有効であること" do
    is_expected.to validate_content_type_of(:avatar).allowing('png', 'jpg', 'jpeg')
  end

  it "画像の拡張子がpng,jpg,jpeg以外であると無効な状態であること" do
    user = User.new(
      avatar: Rack::Test::UploadedFile.new("#{Rails.root}/spec/files/attachment.pdf", 'application/pdf'),
    )
    user.valid?
    expect(user.errors[:avatar]).to include("のContent Typeが不正です。PNG, JPEG, JPEGに対応しています。")
  end
end
