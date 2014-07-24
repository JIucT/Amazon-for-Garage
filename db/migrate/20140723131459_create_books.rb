class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title, limit: 30, null: false
      t.text :description
      t.decimal :price, null: false
      t.integer :in_stock, null: false
      t.references :author, index: true
      t.references :category, index: true

      t.timestamps
    end
  end
end
