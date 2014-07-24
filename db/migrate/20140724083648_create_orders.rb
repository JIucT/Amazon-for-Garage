class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.decimal :total_price, null: false
      t.timestamp :completed_at, null: false
      t.string :state, null: false, default: 'in progress'
      t.integer :billing_address_id, index: true, null: false
      t.integer :shipping_address_id, index: true, nul: false
      t.references :customer, index: true
      t.references :credit_card, index: true

      t.timestamps
    end
  end
end
