class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.integer :item_id, null: false
      t.integer :order_id, null: false
      t.integer :quantity, null: false
      t.integer :price_including_tax, null: false

      t.timestamps
    end
  end
end
