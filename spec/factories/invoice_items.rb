FactoryGirl.define do
  factory :invoice_item do
    item
    invoice
    quantity 1
    unit_price 1
    created_at "2016-10-03 20:07:55"
    updated_at "2016-10-03 20:07:55"
  end
end
