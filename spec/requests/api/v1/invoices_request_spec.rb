require 'rails_helper'

RSpec.describe 'Invoices API' do
  it 'returns a list of invoices' do
    create_list(:invoice, 3)

    get '/api/v1/invoices.json'
    output = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(output.count).to eq(3)
  end

  it 'returns an individual invoice' do
    invoice = create(:invoice, status: 'shipped')

    get "/api/v1/invoices/#{invoice.id}.json"
    output = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(output["status"]).to eq('shipped')
  end

  it 'finds an invoice by id' do
    invoice = create(:invoice, status: 'shipped')

    get "/api/v1/invoices/find.json?id=#{invoice.id}"
    output = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(output["status"]).to eq('shipped')
  end

  it 'finds an invoice by status' do
    create(:invoice, id: 2, status: 'shipped')

    get '/api/v1/invoices/find.json?status=shipped'
    output = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(output["id"]).to eq(2)
  end

  it 'finds an invoice by the time it was created' do
    create(:invoice, status: 'shipped', created_at: '1999-01-01')

    get '/api/v1/invoices/find.json?created_at=1999-01-01'
    output = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(output["status"]).to eq('shipped')
  end

  it 'finds an invoice by the time it was updated' do
    create(:invoice, status: 'shipped', updated_at: '1999-01-01')

    get '/api/v1/invoices/find.json?updated_at=1999-01-01'
    output = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(output["status"]).to eq('shipped')
  end

  it 'finds multiple invoices by status' do
    create_list(:invoice, 2, status: 'shipped')

    get '/api/v1/invoices/find_all.json?status=shipped'
    output = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(output.count).to eq(2)
  end

  it 'finds a random invoice' do
    create(:invoice, status: 'shipped')

    get '/api/v1/invoices/random.json'
    output = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(output["status"]).to eq('shipped')
  end

  it 'returns correct scope of json' do
    invoice = create(:invoice)
    get "/api/v1/invoices/#{invoice.id}.json"
    actual = JSON.parse(response.body)
    expected = {
      'id' => invoice.id,
      'status' => invoice.status,
      'customer_id' => invoice.customer_id,
      'merchant_id' => invoice.merchant_id
    }

    expect(actual).to eq(expected)
  end

  it 'returns a collection of associated transactions' do
    invoice = create(:invoice)
    transaction = create(:transaction, invoice_id: invoice.id, result: 'failed')
    create(:transaction, invoice_id: invoice.id)
    get "/api/v1/invoices/#{invoice.id}/transactions.json"
    actual = JSON.parse(response.body)

    expect(actual.count).to eq(2)
    expect(actual[0]['result']).to eq('failed')
  end

  it 'returns a collection of associated invoice items' do
    invoice = create(:invoice)
    create(:invoice_item, invoice_id: invoice.id, unit_price: 1000)
    create(:invoice_item, invoice_id: invoice.id)

    get "/api/v1/invoices/#{invoice.id}/invoice_items.json"
    actual = JSON.parse(response.body)

    expect(actual.count).to eq(2)
    expect(actual[0]['unit_price']).to eq('10.00')
  end

  it 'returns a collection of associated items' do
    invoice = create(:invoice)
    item1 = create(:item, name: 'Dude')
    item2 = create(:item)
    create(:invoice_item, invoice_id: invoice.id, item_id: item1.id)
    create(:invoice_item, invoice_id: invoice.id, item_id: item2.id)

    get "/api/v1/invoices/#{invoice.id}/items.json"
    actual = JSON.parse(response.body)

    expect(actual.count).to eq(2)
    expect(actual[0]['name']).to eq('Dude')
  end

  it 'returns the associated customer' do
    customer = create(:customer, first_name: 'Dude')
    invoice = create(:invoice, customer_id: customer.id)

    get "/api/v1/invoices/#{invoice.id}/customer.json"
    actual = JSON.parse(response.body)

    expect(actual['first_name']).to eq('Dude')
  end

  it 'returns the associated merchant' do
    merchant = create(:merchant, name: 'Dude')
    invoice = create(:invoice, merchant_id: merchant.id)

    get "/api/v1/invoices/#{invoice.id}/merchant.json"
    actual = JSON.parse(response.body)

    expect(actual['name']).to eq('Dude')
  end
end
