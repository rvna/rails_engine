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

  it 'returns JSON for transaction using find parameters' do
    expected = create(:transaction)
    create(:transaction)
    get "/api/v1/transactions/find.json?invoice_id=#{expected.invoice_id}"
    actual = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(actual['id']).to eq(expected.id)
    expect(actual['invoice_id']).to eq(expected.invoice_id)
  end

  it 'returns JSON for all transactions matching parameters' do
    create(:transaction, result: 'failed')
    create(:transaction)
    create(:transaction)
    get '/api/v1/transactions/find_all.json?result=success'
    actual = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(actual.count).to eq(2)
    expect(actual[1]['id']).to eq(Transaction.last.id)
  end

  it 'returns JSON for a random transaction' do
    expected = create(:transaction)
    get "/api/v1/transactions/random.json"
    actual = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(actual['id']).to eq(expected.id)
  end

  it 'returns correct scope of json' do
    transaction = create(:transaction)
    get "/api/v1/transactions/#{transaction.id}.json"
    actual = JSON.parse(response.body)
    expected = {
      'id' => transaction.id,
      'credit_card_number' => transaction.credit_card_number,
      'result' => transaction.result,
      'invoice_id' => transaction.invoice_id,
    }

    expect(actual).to eq(expected)
  end
end
