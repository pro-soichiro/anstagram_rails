class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable
        #  :omniauthable

  has_many :posts, dependent: :destroy
  has_and_belongs_to_many :departments
  belongs_to :prefecture, optional: true
  has_many :likes, dependent: :destroy
  has_many :likes_posts, through: :likes, source: :post

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true,
    format: { with: /\p{Hiragana}/, message: "はひらがなのみが使えます" }
  validates :first_name_kana, presence: true,
    format: { with: /\p{Hiragana}/, message: "はひらがなのみが使えます" }

  def full_name
    format("%s %s", last_name, first_name)
  end

  def full_name_kana
    format("%s %s", last_name_kana, first_name_kana)
  end
end
