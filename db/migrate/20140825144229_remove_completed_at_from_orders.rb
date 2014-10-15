class RemoveCompletedAtFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :completed_at, :datetime
    change_column_default(:orders, :total_price, 0)
  end
end
