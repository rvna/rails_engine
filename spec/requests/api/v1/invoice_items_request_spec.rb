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
end
