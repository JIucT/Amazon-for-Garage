class ChangeBookAuthorId < ActiveRecord::Migration
  def change
    change_column :books, :author_id, :integer, null:false
  end
end
