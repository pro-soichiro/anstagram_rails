require 'rails_helper'

RSpec.describe Post, type: :model do
  it "キャプション、画像、投稿者情報があれば有効な状態であること" do
    user = User.create(
      last_name: '間宮',
      first_name: '漱一朗',
      email: 'soichiro@gmail.com',
      password: 'password1234'
    )
    post = Post.new(
      caption: 'キャプション',
      image: Rack::Test::UploadedFile.new("#{Rails.root}/spec/files/attachment.jpg", 'image/jpeg'),
      user: user
    )
    expect(post).to be_valid
  end

  it "キャプションがなければ無効な状態であること" do
    post = Post.new(caption: nil)
    post.valid?
    expect(post.errors[:caption]).to include("は必須項目です")
  end

  it "画像がなければ無効な状態であること" do
    post = Post.new(image: nil)
    post.valid?
    expect(post.errors[:image]).to include("は必須項目です")
  end

  it "画像の拡張子にはpng.jpg,jpegが有効であること" do
    is_expected.to validate_content_type_of(:image).allowing('png', 'jpg', 'jpeg')
  end

  it "画像の拡張子がpng,jpg,jpeg以外であると無効な状態であること" do
    post = Post.new(
      image: Rack::Test::UploadedFile.new("#{Rails.root}/spec/files/attachment.pdf", 'application/pdf'),
    )
    post.valid?
    expect(post.errors[:image]).to include("のContent Typeが不正です。PNG, JPEG, JPEGに対応しています。")
  end

  it "投稿者情報がなければ無効な状態であること" do
    post = Post.new(user: nil)
    post.valid?
    expect(post.errors[:user]).to include("を入力してください")
  end
end
