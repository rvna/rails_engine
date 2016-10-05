class Customer < ApplicationRecord
  default_scope { order(id: :asc) }
  has_many :invoices
  has_many :transactions, through: :invoices
end
