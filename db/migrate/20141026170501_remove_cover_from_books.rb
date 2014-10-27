class RemoveCoverFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :cover
  end
end
