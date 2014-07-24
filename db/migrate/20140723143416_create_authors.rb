class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.text :biography

      t.timestamps
    end
  end
end
