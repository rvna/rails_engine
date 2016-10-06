require 'rails_helper'

RSpec.describe Customer, type: :model do
  it 'returns the its favorite merchant' do
    customer = create(:customer)
    merchant1 = create(:merchant, name: 'Pierre')
    invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant1.id)
    transaction1 = create(:transaction, invoice_id: invoice1.id, result: 'success')
    invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant1.id)
    transaction2 = create(:transaction, invoice_id: invoice2.id, result: 'success')
    merchant2 = create(:merchant )
    invoice3 = create(:invoice, customer_id: customer.id, merchant_id: merchant2.id)
    transaction3 = create(:transaction, invoice_id: invoice3.id, result: 'success')
    invoice4 = create(:invoice, customer_id: customer.id, merchant_id: merchant2.id)
    transaction2 = create(:transaction, invoice_id: invoice4.id, result: 'failure')

    actual = customer.top_merchant
    expect(actual.name).to eq('Pierre')
  end
end
