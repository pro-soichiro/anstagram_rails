require 'rails_helper'

RSpec.describe Like, type: :model do
  it "投稿といいねをしたユーザーがあれば有効な状態であること" do
    expect(FactoryBot.build(:like)).to be_valid
  end

  it "ユーザーがなければ無効な状態であること" do
    like = FactoryBot.build(:like, user: nil)
    like.valid?
    expect(like.errors[:user]).to include("を入力してください")
  end

  it "投稿がなければ無効な状態であること" do
    user = FactoryBot.create(:user)
    like = FactoryBot.build(:like, post: nil, user: user)
    like.valid?
    expect(like.errors[:post]).to include("を入力してください")
  end

  it "1投稿1ユーザーが重複すると無効な状態であること" do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post)
    FactoryBot.create(:like, user: user, post: post)

    like = FactoryBot.build(:like, user: user, post: post)
    like.valid?
    expect(like.errors[:user_id]).to include("はすでに存在します")
  end
end
