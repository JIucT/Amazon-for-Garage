class RenameRatingsCustomerIdToUserId < ActiveRecord::Migration
  def change
    rename_column :ratings, :customer_id, :user_id
  end
end
