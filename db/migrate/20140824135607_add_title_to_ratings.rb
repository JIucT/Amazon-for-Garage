class AddTitleToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :title, :string, null: false, default: { Faker::Lorem.sentence(2, 2) }
    change_column :ratings, :title, :string, null: false    
  end
end
