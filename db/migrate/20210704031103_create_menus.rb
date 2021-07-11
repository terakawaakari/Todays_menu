class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.integer :user_id,      null: false
      t.string :menu_image_id, null: false
      t.text :list
      t.integer :category
      t.date :date,            null: false

      t.timestamps
    end
  end
end
