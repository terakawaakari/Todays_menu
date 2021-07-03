class CreateDirections < ActiveRecord::Migration[5.2]
  def change
    create_table :directions do |t|
      t.integer :recipe_id,      null: false
      t.string :process_image_id
      t.text :description,       null: false

      t.timestamps
    end
  end
end
