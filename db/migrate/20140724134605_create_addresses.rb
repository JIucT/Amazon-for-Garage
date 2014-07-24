class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address1, null: false
      t.string :address2, null: false
      t.string :city, null: false
      t.string :country, null: false
      t.string :state, null: false
      t.string :zip_code, null: false
      t.string :mobile_number, null: false

      t.timestamps
    end
  end
end
