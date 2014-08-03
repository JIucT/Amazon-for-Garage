class RenameOrdersCustomerIdToUserId < ActiveRecord::Migration
  def change
    rename_column :orders, :customer_id, :user_id
  end
end
