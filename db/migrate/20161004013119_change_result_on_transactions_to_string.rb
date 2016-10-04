class ChangeResultOnTransactionsToString < ActiveRecord::Migration[5.0]
  def change
    change_column :transactions, :result, :string
  end
end
