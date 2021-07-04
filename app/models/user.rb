class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum sex: { "男性": 0, "女性": 1}

  has_many :recipes, dependent: :destroy
  has_many :menus,   dependent: :destroy

end
