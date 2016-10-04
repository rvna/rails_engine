class ChangeTransactionStatusToCitext < ActiveRecord::Migration[5.0]
  def change
    change_column :transactions, :result, :citext
  end
end
