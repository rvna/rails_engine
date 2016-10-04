require 'rails_helper'

RSpec.describe 'Invoice Items API' do
  it 'returns a list of invoice items' do
    create_list(:invoice_item, 3)
    get '/api/v1/invoice_items'
    output = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(output.count).to eq(3)
  end

  it 'returns an individual invoice item' do
    item = create(:invoice_item, quantity: 6)

    get "/api/v1/invoice_items/#{item.id}"
    output = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(output["quantity"]).to eq(6)
  end

  it 'finds an invoice item by quantity' do
    create(:invoice_item, quantity: 6, unit_price: 222)

    get '/api/v1/invoice_items/find?quantity=6'
    output = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(output["unit_price"]).to eq(222)
  end

  it 'finds multiple invoice items by quantity' do
    create_list(:invoice_item, 2, quantity: 6)

    get '/api/v1/invoice_items/find_all?quantity=6'
    output = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(output.count).to eq(2)
  end

  it 'returns a random invoice item' do
    create(:invoice_item, quantity: 6)

    get '/api/v1/invoice_items/random'
    output = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(output["quantity"]).to eq(6)
  end
end
