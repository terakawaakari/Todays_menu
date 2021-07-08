class CreateBuyItems < ActiveRecord::Migration[5.2]
  def change
    create_table :buy_items do |t|
      t.integer :user_id,   null: false
      t.string :name,       null: false
      t.boolean :is_bought, null: false, default: false

      t.timestamps
    end
  end
end
