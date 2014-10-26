class AddTitleToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :title, :string, null: false
  end
end
