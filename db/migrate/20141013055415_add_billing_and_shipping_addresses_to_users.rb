class AddBillingAndShippingAddressesToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :address_id, :references
    add_column :users, :shipping_address_id, :integer
    add_column :users, :billing_address_id, :integer
  end
end
