json.array! @transactions do |transaction|
  json.(transaction, :id, :credit_card_number, :result, :invoice_id)
end
