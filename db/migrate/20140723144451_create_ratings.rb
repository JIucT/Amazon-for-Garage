class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.text :comment
      t.integer :mark, null: false
      t.references :customer, index: true
      t.references :book, index: true

      t.timestamps
    end
  end
end
