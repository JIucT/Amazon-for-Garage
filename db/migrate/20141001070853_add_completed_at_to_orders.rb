class AddCompletedAtToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :completed_at, :date
    Order.all.each do |order|
      order.completed_at ||= Date.today
      order.save!
    end
  end
end
