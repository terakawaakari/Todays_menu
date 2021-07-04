class Menu < ApplicationRecord

  attachment :menu_image

  has_many :menu_recipes, dependent: :destroy

end
