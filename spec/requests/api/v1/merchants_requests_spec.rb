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

  it 'raises exception if merchant id is not found' do
    get '/api/v1/merchants/0.json'
    actual = JSON.parse(response.body)

    expect(response.status).to eq(404)
    expect(actual['id']).to eq(nil)
    expect(actual['name']).to eq(nil)
    expect(actual['error']).to eq('not-found')
  end

  it 'returns JSON for merchant using find parameters' do
    expected = create(:merchant, name: 'Dude')
    create(:merchant, name: 'Other Merch')
    get '/api/v1/merchants/find?name=dude'
    actual = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(actual['id']).to eq(expected.id)
    expect(actual['name']).to eq('Dude')
    expect(actual['name']).to_not eq('Other Merch')
  end

  it 'raises expection if merchant name does not match records' do
    get '/api/v1/merchants/find?name=no-name'
    actual = JSON.parse(response.body)

    expect(response.status).to eq(404)
    expect(actual['id']).to eq(nil)
    expect(actual['name']).to eq(nil)
    expect(actual['error']).to eq('not-found')
  end

  it 'returns JSON for all merchants matching parameters' do
    create(:merchant, name: 'Dude Workman')
    create(:merchant, name: 'Awesome Dude')
    create(:merchant, name: 'Fuddy Duddy')
    get '/api/v1/merchants/find_all?name=dude'
    actual = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(actual.count).to eq(2)
    expect(actual[0]['id']).to eq(Merchant.first.id)
  end

  it 'raises an exception if none of the merchants have name requested' do
    get '/api/v1/merchants/find_all?name=no-name'
    actual = JSON.parse(response.body)

    expect(response.status).to eq(404)
    expect(actual['id']).to eq(nil)
    expect(actual['name']).to eq(nil)
    expect(actual['error']).to eq('not-found')
  end

  
end
