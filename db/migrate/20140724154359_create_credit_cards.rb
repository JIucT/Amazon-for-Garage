class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.string :number, null: false
      t.datetime :expiration_date, null: false
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.references :customer, index: true

      t.timestamps
    end
  end
end
