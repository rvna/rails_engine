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
  
  it 'returns the top x merchants ranked by total number of items sold' do
    merchant1 = create(:merchant, name: 'Merch1')
    invoice1 = create(:invoice, merchant_id: merchant1.id)
    create(:invoice_item, invoice_id: invoice1.id, quantity: 2)
    create(:transaction, invoice_id: invoice1.id, result: 'success')
    merchant2 = create(:merchant, name: 'Merch2')
    invoice2 = create(:invoice, merchant_id: merchant2.id)
    create(:invoice_item, invoice_id: invoice2.id, quantity: 5)
    create(:transaction, invoice_id: invoice2.id, result: 'success')
    merchant3 = create(:merchant, name: 'Merch3')
    invoice3 = create(:invoice, merchant_id: merchant3.id)
    create(:invoice_item, invoice_id: invoice3.id, quantity: 5)
    create(:transaction, invoice_id: invoice3.id, result: 'failed')
    merchant4 = create(:merchant, name: 'Merch4')
    invoice4 = create(:invoice, merchant_id: merchant4.id)
    create(:invoice_item, invoice_id: invoice4.id, quantity: 1)
    create(:transaction, invoice_id: invoice4.id, result: 'success')

    result = Merchant.top_selling_items(2)

    expect(result[0]['name']).to eq('Merch2')
    expect(result[1]['name']).to eq('Merch1')
    expect(result.length).to eq(2)
  end
    
  it 'returns the top x merchants ranked by total revenue' do
    merchant1 = create(:merchant, name: 'Merch1')
    invoice1 = create(:invoice, merchant_id: merchant1.id)
    create(:invoice_item, invoice_id: invoice1.id, unit_price: 200)
    create(:transaction, invoice_id: invoice1.id, result: 'success')
    merchant2 = create(:merchant, name: 'Merch2')
    invoice2 = create(:invoice, merchant_id: merchant2.id)
    create(:invoice_item, invoice_id: invoice2.id, unit_price: 500)
    create(:transaction, invoice_id: invoice2.id, result: 'success')
    merchant3 = create(:merchant, name: 'Merch3')
    invoice3 = create(:invoice, merchant_id: merchant3.id)
    create(:invoice_item, invoice_id: invoice3.id, unit_price: 500)
    create(:transaction, invoice_id: invoice3.id, result: 'failed')
    merchant4 = create(:merchant, name: 'Merch4')
    invoice4 = create(:invoice, merchant_id: merchant4.id)
    create(:invoice_item, invoice_id: invoice4.id, unit_price: 100)
    create(:transaction, invoice_id: invoice4.id, result: 'success')

    result = Merchant.most_revenue(2)

    expect(result[0]['name']).to eq('Merch2')
    expect(result[1]['name']).to eq('Merch1')
    expect(result.length).to eq(2)
  end

  it 'finds the total revenue across all merchants by date' do
    merchant1 = create(:merchant, name: 'Merch1')
    invoice1 = create(:invoice, merchant_id: merchant1.id, created_at: '2012-03-16 11:56:05')
    create(:invoice_item, invoice_id: invoice1.id, unit_price: 200, quantity: 2)
    create(:transaction, invoice_id: invoice1.id, result: 'success')
    merchant2 = create(:merchant, name: 'Merch2')
    invoice2 = create(:invoice, merchant_id: merchant2.id, created_at: '2012-03-16 11:56:05')
    create(:invoice_item, invoice_id: invoice2.id, unit_price: 500)
    create(:transaction, invoice_id: invoice2.id, result: 'success')
    merchant3 = create(:merchant, name: 'Merch3')
    invoice3 = create(:invoice, merchant_id: merchant3.id, created_at: '2012-03-16 11:56:05')
    create(:invoice_item, invoice_id: invoice3.id, unit_price: 500)
    create(:transaction, invoice_id: invoice3.id, result: 'failed')
    merchant4 = create(:merchant, name: 'Merch4')
    invoice4 = create(:invoice, merchant_id: merchant4.id, created_at: '2012-04-16 11:55:05')
    create(:invoice_item, invoice_id: invoice4.id, unit_price: 100)
    create(:transaction, invoice_id: invoice4.id, result: 'success')

    result = Merchant.total_revenue_by_day('2012-03-16 11:56:05')

    expect(result).to eq('9.00')
  end

  it 'returns a given merchants total revenue by date' do
    merchant = create(:merchant)
    invoice1 = create(:invoice, merchant_id: merchant.id, created_at: '2012-03-16 11:56:05')
    create(:invoice_item, invoice_id: invoice1.id, unit_price: 10000, quantity: 2)
    create(:transaction, invoice_id: invoice1.id, result: 'success')
    invoice2 = create(:invoice, merchant_id: merchant.id, created_at: '2012-04-16 11:56:05')
    create(:invoice_item, invoice_id: invoice2.id, unit_price: 10000)
    create(:transaction, invoice_id: invoice2.id, result: 'success')
    invoice3 = create(:invoice, merchant_id: merchant.id, created_at: '2012-03-16 11:56:05')
    create(:invoice_item, invoice_id: invoice3.id, unit_price: 10000)
    create(:transaction, invoice_id: invoice3.id, result: 'failed')

    result = merchant.total_revenue('2012-03-16 11:56:05')

    expect(result).to eq('200.00')
  end

end
