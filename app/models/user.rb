class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_and_belongs_to_many :departments

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\p{Hiragana}/, message: "ひらがなのみが使えます" }
  validates :first_name_kana, presence: true, format: { with: /\p{Hiragana}/, message: "ひらがなのみが使えます" }
  validates :email, presence: true

  def full_name
    format("%s %s", last_name, first_name)
  end

  def full_name_kana
    format("%s %s", last_name_kana, first_name_kana)
  end

end
