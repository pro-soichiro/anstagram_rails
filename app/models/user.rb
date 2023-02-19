class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_and_belongs_to_many :departments
  belongs_to :prefecture, optional: true

  def full_name
    format("%s %s", last_name, first_name)
  end

  def full_name_kana
    format("%s %s", last_name_kana, first_name_kana)
  end
end
