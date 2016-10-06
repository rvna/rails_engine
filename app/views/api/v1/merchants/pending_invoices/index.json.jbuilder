json.array! @pending_invoices do |customer|
  json.(customer, :id, :first_name, :last_name)
end
