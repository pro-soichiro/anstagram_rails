require "test_helper"

class Form::UserTest < ActiveSupport::TestCase
  test "必要最低限の内容があれば保存されること" do
    form_user = Form::User.new({
      last_name: "間宮",
      first_name: "漱一朗",
      last_name_kana: "まみや",
      first_name_kana: "そういちろう",
      email: "sample@sample.com"
    })
    assert form_user.save
  end

  test "last_nameがないと保存できないこと" do
    form_user = Form::User.new({
      last_name: "",
      first_name: "漱一朗",
      last_name_kana: "まみや",
      first_name_kana: "そういちろう",
      email: "sample@sample.com",
    })
    form_user.valid?
    assert_equal "苗字を入力してください",
      form_user.errors.full_messages_for(:last_name).first
  end

  test "first_nameがないと保存できないこと" do
    form_user = Form::User.new({
      last_name: "間宮",
      first_name: "",
      last_name_kana: "まみや",
      first_name_kana: "そういちろう",
      email: "sample@sample.com",
    })
    form_user.valid?
    assert_equal "名前を入力してください",
      form_user.errors.full_messages_for(:first_name).first
  end

  test "last_name_kanaがひらがなでないと保存できないこと" do
    form_user = Form::User.new({
      last_name: "間宮",
      first_name: "漱一朗",
      last_name_kana: "マミヤ",
      first_name_kana: "そういちろう",
      email: "sample@sample.com",
    })
    form_user.valid?
    assert_equal "みょうじはひらがなのみが使えます",
      form_user.errors.full_messages_for(:last_name_kana).first
  end

  test "first_name_kanaがひらがなでないと保存できないこと" do
    form_user = Form::User.new({
      last_name: "間宮",
      first_name: "漱一朗",
      last_name_kana: "まみや",
      first_name_kana: "ソウイチロウ",
      email: "sample@sample.com",
    })
    form_user.valid?
    assert_equal "なまえはひらがなのみが使えます",
      form_user.errors.full_messages_for(:first_name_kana).first
  end

  test "出身地の詳細が記入されている時都道府県が選択されていないと保存できないこと" do
    form_user = Form::User.new({
      last_name: "間宮",
      first_name: "漱一朗",
      last_name_kana: "まみや",
      first_name_kana: "そういちろう",
      email: "sample@sample.com",
      prefecture_id: "",
      birthplace_detail: "賀茂郡",
    })
    form_user.valid?
    assert_equal "都道府県を入力してください",
      form_user.errors.full_messages_for(:prefecture_id).first
  end

  test "都道府県idがあれば保存できること" do
    prefecture = Prefecture.create(name: '北海道')
    form_user = Form::User.new({
      last_name: "間宮",
      first_name: "漱一朗",
      last_name_kana: "まみや",
      first_name_kana: "そういちろう",
      email: "sample@sample.com",
      prefecture_id: prefecture.id,
      birthplace_detail: "賀茂郡",
    })
    assert form_user.save
    assert_equal '北海道', User.find(form_user.id).prefecture.name
  end

  test "部署idがあれば保存できること" do
    department = Department.create(name: 'プロダクト開発',
                                   description: 'エンジニアチームです。')
    form_user = Form::User.new({
      last_name: "間宮",
      first_name: "漱一朗",
      last_name_kana: "まみや",
      first_name_kana: "そういちろう",
      email: "sample@sample.com",
      departments: [department],
    })
    assert form_user.save
    assert_equal 'プロダクト開発', User.find(form_user.id).departments.first.name
  end

  test "複数の部署idが保存できること" do
    product = Department.create(name: 'プロダクト開発',
                                description: 'エンジニアチームです。')
    marketing = Department.create(name: 'マーケティング',
                                  description: 'マーケティングチームです。')
    form_user = Form::User.new({
      last_name: "間宮",
      first_name: "漱一朗",
      last_name_kana: "まみや",
      first_name_kana: "そういちろう",
      email: "sample@sample.com",
      departments: [product, marketing],
    })
    assert form_user.save
    assert_equal 2, User.find(form_user.id).departments.size
  end

  # test "find" do
  #   form_user = Form::User.new(
  #     last_name: "間宮",
  #     first_name: "漱一朗",
  #     last_name_kana: "まみや",
  #     first_name_kana: "そういちろう",
  #     email: "sample@sample.com",
  #   )
  #   form_user.save

  #   find_user = Form::User.find(form_user.id)
  #   assert_equal form_user.id, find_user.id
  # end

  # test "update" do
  #   form_user = Form::User.new(
  #     last_name: "間宮",
  #     first_name: "漱一朗",
  #     last_name_kana: "まみや",
  #     first_name_kana: "そういちろう",
  #     email: "sample@sample.com",
  #   )
  #   form_user.save

  #   find_user = Form::User.find(form_user.id)
  #   find_user.update(
  #     last_name: "間宮fix",
  #     first_name: "漱一朗fix",
  #     last_name_kana: "まみやfix",
  #     first_name_kana: "そういちろうfix",
  #     email: "fixsample@sample.com",
  #   )

  #   updated_user = Form::User.find(find_user.id)
  #   assert_equal "間宮fix", updated_user.last_name
  #   assert_equal "漱一朗fix", updated_user.first_name
  #   assert_equal "まみやfix", updated_user.last_name_kana
  #   assert_equal "そういちろうfix", updated_user.first_name_kana
  #   assert_equal "fixsample@sample.com", updated_user.email
  # end

  # test "update prefecture" do
  #   hokkaido = Prefecture.create(name: '北海道')
  #   kanagawa = Prefecture.create(name: '神奈川県')
  #   form_user = Form::User.new(
  #     last_name: "間宮",
  #     first_name: "漱一朗",
  #     last_name_kana: "まみや",
  #     first_name_kana: "そういちろう",
  #     email: "sample@sample.com",
  #     prefecture_id: hokkaido.id
  #   )
  #   form_user.save
  #   assert_equal "北海道", form_user.user.prefecture.name

  #   find_user = Form::User.find(form_user.id)
  #   find_user.update(
  #     last_name: "間宮",
  #     first_name: "漱一朗",
  #     last_name_kana: "まみや",
  #     first_name_kana: "そういちろう",
  #     email: "sample@sample.com",
  #     prefecture_id: kanagawa.id
  #   )

  #   updated_user = Form::User.find(find_user.id)
  #   assert_equal "神奈川県", updated_user.user.prefecture.name
  # end
end
