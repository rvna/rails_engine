json.array! @invoice_items do |invoice_item|
  json.(invoice_item, :id, :item_id, :invoice_id, :quantity)
  json.unit_price invoice_item.unit_price_in_dollars
end
