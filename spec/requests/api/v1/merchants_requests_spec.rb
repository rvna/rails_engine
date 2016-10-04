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
    get "/api/v1/merchants/#{expected.id}"
    actual = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(actual['id']).to eq(expected.id)
    expect(actual['name']).to eq('Dude')
  end

  it 'raises exception if merchant id is not found' do
    expected = create(:merchant, name: 'Dude')
    get "/api/v1/merchants/0"
    actual = JSON.parse(response.body)

    expect(response.status).to eq(404)
    expect(actual['id']).to eq(nil)
    expect(actual['name']).to eq(nil)
    expect(actual['error']).to eq('not-found')
  end
end
