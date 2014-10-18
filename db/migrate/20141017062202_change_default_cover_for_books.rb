class ChangeDefaultCoverForBooks < ActiveRecord::Migration
  def change
    change_column :books, :cover, :string, default: "default.png", null: false
  end
end
