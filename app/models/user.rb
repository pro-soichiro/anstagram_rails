class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  has_many :posts, dependent: :destroy
  has_and_belongs_to_many :departments
  belongs_to :prefecture, optional: true
  has_many :likes, dependent: :destroy
  has_many :likes_posts, through: :likes, source: :post
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    attachable.variant :preview, resize_to_limit: [300, 300]
  end

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :avatar, content_type: %i[png jpg jpeg]

  def full_name
    format('%s %s', last_name, first_name)
  end

  def full_name_kana
    format('%s %s', last_name_kana, first_name_kana)
  end

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.skip_confirmation!
    end
  end
end
