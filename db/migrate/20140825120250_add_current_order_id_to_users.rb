class AddCurrentOrderIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_order_id, :integer, default: nil
  end
end
