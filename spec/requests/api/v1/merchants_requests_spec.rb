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
end
