require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it 'returns a given merchants total revenue' do
    merchant = create(:merchant)
    invoice1 = create(:invoice, merchant_id: merchant.id)
    create(:invoice_item, invoice_id: invoice1.id, unit_price: 10000, quantity: 2)
    create(:transaction, invoice_id: invoice1.id, result: 'success')
    invoice2 = create(:invoice, merchant_id: merchant.id)
    create(:invoice_item, invoice_id: invoice2.id, unit_price: 10000)
    create(:transaction, invoice_id: invoice2.id, result: 'success')
    invoice3 = create(:invoice, merchant_id: merchant.id)
    create(:invoice_item, invoice_id: invoice3.id, unit_price: 10000)
    create(:transaction, invoice_id: invoice3.id, result: 'failed')

    expect(merchant.total_revenue).to eq('300.00')
  end

end
