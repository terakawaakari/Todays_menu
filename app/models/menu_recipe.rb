class MenuRecipe < ApplicationRecord

  belongs_to :menu
  belongs_to :recipe

  # バリデーションをかけるとcocoonで保存できない
  # validates :menu_id, presence: true
  # validates :recipe_id, presence: true

end
