class RemoveFirstnameAndLastnameFromCreditCard < ActiveRecord::Migration
  def change
    remove_column :credit_cards, :firstname
    remove_column :credit_cards, :lastname
  end
end
