class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :password_digest, null: false
      t.string :email, null: false
      t.string :firstname, null: false
      t.string :lastname, null: false

      t.timestamps
    end
  end
end
