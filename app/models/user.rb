class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\p{Hiragana}/, message: "ひらがなのみが使えます" }
  validates :first_name_kana, presence: true, format: { with: /\p{Hiragana}/, message: "ひらがなのみが使えます" }
  validates :email, presence: true

  def full_name
    format("%s %s", last_name, first_name)
  end
end
