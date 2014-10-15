class RemoveCurrentOrderFromUsers < ActiveRecord::Migration
  def change
    remove_reference :users, :current_order, index: true
  end
end
