class ChangeAddressesMobileNumber < ActiveRecord::Migration
  def change
    change_column :addresses, :mobile_number, :string, null: true    
  end
end
