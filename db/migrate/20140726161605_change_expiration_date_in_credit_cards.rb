class ChangeExpirationDateInCreditCards < ActiveRecord::Migration
  def change
    change_column :credit_cards, :expiration_date, :date
  end
end
