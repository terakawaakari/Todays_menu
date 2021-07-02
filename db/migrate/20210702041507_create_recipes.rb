class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.integer :user_id,        null: false
      t.string :name,            null: false
      t.string :recipe_image_id
      t.string :serving
      t.integer :genre,          null: false
      t.integer :category,       null: false
      t.integer :taste,          null: false
      t.integer :time
      t.float :popularity
      t.text :url
      t.text :note
      t.boolean :is_open,        null: false

      t.timestamps

      t.index :id, unique: true
    end
  end
end
