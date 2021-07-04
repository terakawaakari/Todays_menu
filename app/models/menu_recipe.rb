class MenuRecipe < ApplicationRecord

  belongs_to :menu
  belongs_to :recipe

  validates :menu_id, presence: true
  validates :recipe_id, presence: true

end
