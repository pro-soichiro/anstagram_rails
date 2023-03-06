# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Form::User, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  it '姓、名、せい、めいがあれば有効な状態であること' do
    user = Form::User.new(FactoryBot.attributes_for(:form_user), user: @user)
    expect(user).to be_valid
  end

  it '名がなければ無効な状態であること' do
    user = Form::User.new(FactoryBot.attributes_for(:form_user, first_name: nil), user: @user)
    user.valid?
    expect(user.errors[:first_name]).to include('は必須項目です')
  end

  it '姓がなければ無効な状態であること' do
    user = Form::User.new(FactoryBot.attributes_for(:form_user, last_name: nil), user: @user)
    user.valid?
    expect(user.errors[:last_name]).to include('は必須項目です')
  end

  it 'めいがなければ無効な状態であること' do
    user = Form::User.new(FactoryBot.attributes_for(:form_user, first_name_kana: nil), user: @user)
    user.valid?
    expect(user.errors[:first_name_kana]).to include('は必須項目です')
  end

  it 'せいがなければ無効な状態であること' do
    user = Form::User.new(FactoryBot.attributes_for(:form_user, last_name_kana: nil), user: @user)
    user.valid?
    expect(user.errors[:last_name_kana]).to include('は必須項目です')
  end

  it 'めいがひらがなでなければ無効な状態であること' do
    user = Form::User.new(FactoryBot.attributes_for(:form_user, first_name_kana: 'ソウイチロウ'), user: @user)
    user.valid?
    expect(user.errors[:first_name_kana]).to include('はひらがなのみが使えます')
  end

  it 'せいがひらがなでなければ無効な状態であること' do
    user = Form::User.new(FactoryBot.attributes_for(:form_user, last_name_kana: 'マミヤ'), user: @user)
    user.valid?
    expect(user.errors[:last_name_kana]).to include('はひらがなのみが使えます')
  end

  it '出身地詳細が入力されている場合、都道府県が選択されていなければ無効な状態であること' do
    user = Form::User.new(FactoryBot.attributes_for(:form_user, prefecture_id: nil, birthplace_detail: '茅ヶ崎市'),
                          user: @user)
    user.valid?
    expect(user.errors[:prefecture_id]).to include('は必須項目です')
  end

  it '出身地詳細が入力されていない場合、都道府県が選択されていなくても有効な状態であること' do
    user = Form::User.new(FactoryBot.attributes_for(:form_user, prefecture_id: nil, birthplace_detail: nil),
                          user: @user)
    user.valid?
    expect(user.errors[:prefecture_id]).to_not include('は必須項目です')
  end
end
