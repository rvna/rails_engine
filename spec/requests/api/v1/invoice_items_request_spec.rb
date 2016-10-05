require 'rails_helper'

RSpec.describe 'Invoice Items API' do
  it 'returns a list of invoice items' do
    create_list(:invoice_item, 3)
    get '/api/v1/invoice_items.json'
    output = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(output.count).to eq(3)
  end

  it 'returns an individual invoice item' do
    item = create(:invoice_item, quantity: 6)

    get "/api/v1/invoice_items/#{item.id}.json"
    output = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(output["quantity"]).to eq(6)
  end

  it 'finds an invoice item by quantity' do
    create(:invoice_item, quantity: 6, unit_price: 222)

    get '/api/v1/invoice_items/find.json?quantity=6'
    output = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(output["unit_price"]).to eq(222)
  end

  it 'finds multiple invoice items by quantity' do
    create_list(:invoice_item, 2, quantity: 6)

    get '/api/v1/invoice_items/find_all.json?quantity=6'
    output = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(output.count).to eq(2)
  end

  it 'returns a random invoice item' do
    create(:invoice_item, quantity: 6)

    get '/api/v1/invoice_items/random.json'
    output = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(output["quantity"]).to eq(6)
  end

  it 'returns correct scope of json' do
    invoice_item = create(:invoice_item)
    get "/api/v1/invoice_items/#{invoice_item.id}.json"
    actual = JSON.parse(response.body)
    expected = {
      'id' => invoice_item.id,
      'item_id' => invoice_item.item_id,
      'invoice_id' => invoice_item.invoice_id,
      'quantity' => invoice_item.quantity,
      'unit_price' => invoice_item.unit_price
    }

    expect(actual).to eq(expected)
  end
end
