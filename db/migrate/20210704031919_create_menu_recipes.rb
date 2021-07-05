class CreateMenuRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_recipes do |t|
      t.integer :menu_id,   null: false
      t.integer :recipe_id, null: false

      t.timestamps
    end
  end
end
