require 'rails_helper'

RSpec.describe Department, type: :model do
  it "部署名と説明があれば有効な状態であること" do
    department = Department.new(
      name: '部署名',
      description: '部署の説明'
    )
    expect(department).to be_valid
  end

  it "部署名がなければ無効な状態であること" do
    department = Department.new(
      name: nil
    )
    department.valid?
    expect(department.errors[:name]).to include("は必須項目です")
  end

  it "部署の説明がなければ無効な状態であること" do
    department = Department.new(
      description: nil
    )
    department.valid?
    expect(department.errors[:description]).to include("は必須項目です")
  end
end
