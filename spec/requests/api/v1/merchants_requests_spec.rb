require 'rails_helper'

describe 'merchants endpoints functioning' do
  it 'returns JSON list of all merchants' do
    create_list(:merchant, 3)
    get '/api/v1/merchants.json'
    merchants = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(merchants.count).to eq(3)
    expect(merchants[0]['id']).to eq(Merchant.first.id)
  end

  it 'returns JSON for specific merchant' do
    expected = create(:merchant, name: 'Dude')
    get "/api/v1/merchants/#{expected.id}.json"
    actual = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(actual['id']).to eq(expected.id)
    expect(actual['name']).to eq('Dude')
  end

  it 'returns JSON for merchant using find parameters' do
    expected = create(:merchant, name: 'Dude')
    create(:merchant, name: 'Other Merch')
    get '/api/v1/merchants/find.json?name=Dude'
    actual = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(actual['id']).to eq(expected.id)
    expect(actual['name']).to eq('Dude')
    expect(actual['name']).to_not eq('Other Merch')
  end

  it 'returns JSON for all merchants matching parameters' do
    create(:merchant, name: 'Dude Workman')
    create(:merchant, name: 'Awesome Dude')
    create(:merchant, name: 'Fuddy Duddy')
    get '/api/v1/merchants/find_all.json?name=Dude Workman'
    actual = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(actual.count).to eq(1)
    expect(actual[0]['id']).to eq(Merchant.first.id)
  end

  it 'returns JSON for a random merchant' do
    expected = create(:merchant, name: 'Dude')
    get "/api/v1/merchants/random.json"
    actual = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(actual['id']).to eq(expected.id)
    expect(actual['name']).to eq('Dude')
  end

  it 'returns correct scope of json' do
    merchant = create(:merchant)
    get "/api/v1/merchants/#{merchant.id}.json"
    actual = JSON.parse(response.body)
    expected = {
      'id' => merchant.id,
      'name' => merchant.name,
    }

    expect(actual).to eq(expected)
  end

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

    get "/api/v1/merchants/#{merchant.id}/revenue.json"
    actual = JSON.parse(response.body)

    expect(actual['revenue']).to eq('300.00')
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

    get '/api/v1/merchants/most_items.json?quantity=2'
    actual = JSON.parse(response.body)

    expect(actual[0]['name']).to eq('Merch2')
    expect(actual[1]['name']).to eq('Merch1')
    expect(actual.count).to eq(2)
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

    get '/api/v1/merchants/most_revenue.json?quantity=2'
    actual = JSON.parse(response.body)

    expect(actual[0]['name']).to eq('Merch2')
    expect(actual[1]['name']).to eq('Merch1')
    expect(actual.count).to eq(2)
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

    get '/api/v1/merchants/revenue.json?date=2012-03-16 11:56:05'
    actual = JSON.parse(response.body)

    expect(actual['total_revenue']).to eq('9.00')
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

    get "/api/v1/merchants/#{merchant.id}/revenue.json?date=2012-03-16 11:56:05"
    actual = JSON.parse(response.body)

    expect(actual['revenue']).to eq('200.00')
  end
end
