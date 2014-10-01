class RemoveAddress2FromAddresses < ActiveRecord::Migration
  def change
    remove_column :addresses, :address2
  end
end
