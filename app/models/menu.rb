class Menu < ApplicationRecord

  attachment :menu_image

  enum category: { "朝食": 0, "昼食": 1, "夕食": 2, "その他": 3 }

  has_many :menu_recipes, dependent: :destroy
  has_many :menus,        through: :menu_recipes

  accepts_nested_attributes_for :menu_recipes, allow_destroy: true

end
