class Form::User
  include ActiveModel::Model
  include ActiveModel::Attributes

  USER_ATTR = %i(
    last_name first_name last_name_kana first_name_kana
    email joined_on born_on nickname special_skill pastime
    motto motto_description career self_introduction
    birthplace_detail prefecture_id
  )

  attribute :id, :integer
  attribute :last_name, :string
  attribute :first_name, :string
  attribute :last_name_kana, :string
  attribute :first_name_kana, :string
  attribute :email, :string
  attribute :joined_on, :date
  attribute :born_on, :date
  attribute :nickname, :string
  attribute :special_skill, :string
  attribute :pastime, :string
  attribute :motto, :string
  attribute :motto_description, :string
  attribute :career, :string
  attribute :self_introduction, :string
  attribute :birthplace_detail, :string
  attribute :prefecture_id, :integer
  attribute :departments, :integer, default: -> { [] }

  attr_accessor :user, :departments

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true,
    format: { with: /\p{Hiragana}/, message: "はひらがなのみが使えます" }
  validates :first_name_kana, presence: true,
    format: { with: /\p{Hiragana}/, message: "はひらがなのみが使えます" }
  validates :email, presence: true
  validates :prefecture_id, presence: true, if: -> { birthplace_detail.present? }

  delegate :persisted?, to: :user

  # def initialize(attributes = nil)
  #   @user = user
  #   @departments = user.departments
  #   attributes ||= default_attributes
  #   super(attributes)
  # end

  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      user.save!
      self.id = user.id
      user.departments = Department.where(id: departments)
    end

    true
  end

  def self.find(params_id)
    form_user = self.new

    form_user.user = User.find(params_id)
    form_user.departments = form_user.user.departments
    form_user.assign_attributes(form_user.default_attributes)

    form_user
  end

  def update(form_user_params)
    form = Form::User.new(form_user_params)
    if form.invalid?
      form_user_params[:departments]&.map!(&:to_i)
      self.assign_attributes(form_user_params)
      errors.merge!(form.errors)
      return false
    end

    ActiveRecord::Base.transaction do
      departments_params = form_user_params.delete(:departments)
      user_params = form_user_params

      user.update!(user_params)
      user.departments = Department.where(id: departments_params)
    end

    true
  end


  def default_attributes
    {
      id: user.id,
      last_name: user.last_name,
      first_name: user.first_name,
      last_name_kana: user.last_name_kana,
      first_name_kana: user.first_name_kana,
      email: user.email,
      joined_on: user.joined_on,
      born_on: user.born_on,
      nickname: user.nickname,
      special_skill: user.special_skill,
      pastime: user.pastime,
      motto: user.motto,
      motto_description: user.motto_description,
      career: user.career,
      self_introduction: user.self_introduction,
      prefecture_id: user.prefecture_id,
      birthplace_detail: user.birthplace_detail,
      departments: user.department_ids
    }
  end


  def user
    @user ||= User.new(
      last_name: last_name,
      first_name: first_name,
      last_name_kana: last_name_kana,
      first_name_kana: first_name_kana,
      email: email,
      joined_on: joined_on,
      born_on: born_on,
      nickname: nickname,
      special_skill: special_skill,
      pastime: pastime,
      motto: motto,
      motto_description: motto_description,
      career: career,
      self_introduction: self_introduction,
      prefecture_id: prefecture_id,
      birthplace_detail: birthplace_detail,
    )
  end
end