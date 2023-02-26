class Form::User
  include ActiveModel::Model

  USER_ATTR = %i(
    last_name first_name last_name_kana first_name_kana
    joined_on born_on nickname special_skill pastime
    motto motto_description career self_introduction
    birthplace_detail prefecture_id avatar
  )

  attr_accessor :id
  attr_accessor *USER_ATTR
  attr_accessor :departments

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true,
    format: { with: /\p{Hiragana}/, message: "はひらがなのみが使えます" }
  validates :first_name_kana, presence: true,
    format: { with: /\p{Hiragana}/, message: "はひらがなのみが使えます" }
  validates :prefecture_id, presence: true, if: -> { birthplace_detail.present? }

  delegate :persisted?, to: :user

  def to_model
    user
  end

  def initialize(attributes = nil, user: User.new)
    @user = user
    attributes ||= default_attributes
    super(attributes)
  end

  def save
    departments.map!(&:to_i)
    return if invalid?

    ActiveRecord::Base.transaction do
      user.update!(
        last_name: last_name,
        first_name: first_name,
        last_name_kana: last_name_kana,
        first_name_kana: first_name_kana,
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
      user.avatar.attach(avatar) if avatar
      user.departments = Department.where(id: departments)
      self.id = user.id
      true
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  private
    attr_reader :user

    def default_attributes
      {
        id: user.id,
        last_name: user.last_name,
        first_name: user.first_name,
        last_name_kana: user.last_name_kana,
        first_name_kana: user.first_name_kana,
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
        departments: user.department_ids,
        avatar: user.avatar
      }
    end
end