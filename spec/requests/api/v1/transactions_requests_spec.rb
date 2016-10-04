require 'rails_helper'

describe 'transactions endpoints functioning' do
  it 'returns JSON list of all transactions' do
    create_list(:transaction, 3)
    get '/api/v1/transactions.json'
    transactions = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(transactions.count).to eq(3)
    expect(transactions[0]['id']).to eq(Transaction.first.id)
  end

  it 'returns JSON for specific transaction' do
    expected = create(:transaction)
    get "/api/v1/transactions/#{expected.id}.json"
    actual = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(actual['id']).to eq(expected.id)
    expect(actual['invoice_id']).to eq(expected.invoice_id)
  end

  it 'raises exception if transaction id is not found' do
    get '/api/v1/transactions/0.json'
    actual = JSON.parse(response.body)

    expect(response.status).to eq(404)
    expect(actual['id']).to eq(nil)
    expect(actual['invoice_id']).to eq(nil)
    expect(actual['error']).to eq('not-found')
  end

  it 'returns JSON for transaction using find parameters' do
    expected = create(:transaction)
    create(:transaction)
    get "/api/v1/transactions/find?invoice_id=#{expected.invoice_id}"
    actual = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(actual['id']).to eq(expected.id)
    expect(actual['invoice_id']).to eq(expected.invoice_id)
  end

  it 'returns JSON for all transactions matching parameters' do
    create(:transaction, result: 'failed')
    create(:transaction)
    create(:transaction)
    get '/api/v1/transactions/find_all?result=success'
    actual = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(actual.count).to eq(2)
    expect(actual[1]['id']).to eq(Transaction.last.id)
  end

  it 'raises an exception if none of the transactions have name requested' do
    get '/api/v1/transactions/find_all?name=no-name'
    actual = JSON.parse(response.body)

    expect(response.status).to eq(404)
    expect(actual['id']).to eq(nil)
    expect(actual['error']).to eq('not-found')
  end

  it 'returns JSON for a random transaction' do
    expected = create(:transaction)
    get "/api/v1/transactions/random.json"
    actual = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(actual['id']).to eq(expected.id)
  end
end
