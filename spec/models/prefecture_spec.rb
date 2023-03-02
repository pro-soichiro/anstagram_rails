require 'rails_helper'

RSpec.describe Prefecture, type: :model do
  it "名前があれば有効な状態であること" do
    prefecture = Prefecture.new(name: '都道府県名')
    expect(prefecture).to be_valid
  end

  it "名前がなければ無効な状態であること" do
    prefecture = Prefecture.new(name: nil)
    prefecture.valid?
    expect(prefecture.errors[:name]).to include("は必須項目です")
  end
end
