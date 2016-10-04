class ChangeCustomerFirstNameToCitext < ActiveRecord::Migration[5.0]
  def change
    change_column :customers, :first_name, :citext
  end
end
