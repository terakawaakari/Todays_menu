class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum sex: { "男性": 0, "女性": 1}

  has_many :recipes,   dependent: :destroy
  has_many :menus,     dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :buy_items, dependent: :destroy

  validates :name,       presence: true
  validates :email,      presence: true
  validates :password,   presence: true
  # validates :sex,        presence: true
  # validates :birth_date, presence: true

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = "ゲスト"
      user.birth_date = "2021-07-01"
      user.sex = "男性"
      user.password = SecureRandom.urlsafe_base64
    end
  end

end
