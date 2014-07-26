class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.decimal :price, null: false
      t.integer :quantity, null: false
      t.references :book, index: true
      t.references :order, index: true

      t.timestamps
    end
  end
end
