class ChangeColumnNullOrdersBillingAddress < ActiveRecord::Migration
  def change
    change_column_null :orders, :billing_address_id, true
  end
end
