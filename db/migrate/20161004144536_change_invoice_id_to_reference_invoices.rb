class ChangeInvoiceIdToReferenceInvoices < ActiveRecord::Migration[5.0]
  def change
    remove_column :transactions, :invoice_id
    add_reference :transactions, :invoice, foreign_key: true
  end
end
