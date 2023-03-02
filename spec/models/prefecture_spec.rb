require 'rails_helper'

RSpec.describe Prefecture, type: :model do
  it "名前があれば有効な状態であること" do
    expect(FactoryBot.build(:prefecture)).to be_valid
  end

  it "名前がなければ無効な状態であること" do
    prefecture = FactoryBot.build(:prefecture, name: nil)
    prefecture.valid?
    expect(prefecture.errors[:name]).to include("は必須項目です")
  end
end
