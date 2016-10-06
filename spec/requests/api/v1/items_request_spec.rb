require 'rails_helper'

RSpec.describe 'Items API' do
  it 'returns a list of items' do
   create_list(:item, 3)

   get '/api/v1/items.json'
   output = JSON.parse(response.body)

   expect(response.status).to eq(200)
   expect(output.count).to eq(3)
  end

  it 'returns a single item' do
   item = create(:item, name: 'cucumber')

   get "/api/v1/items/#{item.id}.json"
   output = JSON.parse(response.body)

   expect(response.status).to eq(200)
   expect(output["name"]).to eq('cucumber')
  end

  it 'finds an item by name' do
   create(:item, name: 'cucumber', description: 'green')

   get '/api/v1/items/find.json?name=cucumber'
   output = JSON.parse(response.body)

   expect(response.status).to eq(200)
   expect(output["description"]).to eq('green')
  end

  it 'finds an item by price' do
   item = create(:item, name: 'cucumber', unit_price: 123)
   get '/api/v1/items/find.json?unit_price=1.23'
   output = JSON.parse(response.body)

   expect(response.status).to eq(200)
   expect(output['name']).to eq('cucumber')
  end

  it 'finds multiple items by name' do
   create_list(:item, 2, name: 'cucumber')

   get '/api/v1/items/find_all.json?name=cucumber'
   output = JSON.parse(response.body)

   expect(response.status).to eq(200)
   expect(output.count).to eq(2)
  end

  it 'finds saveral items by price' do
   create(:item, name: 'cucumber', unit_price: 123)
   create(:item, name: 'apple', unit_price: 120)
   create(:item, name: 'playstation', unit_price: 123)
   get '/api/v1/items/find_all.json?unit_price=1.23'
   output = JSON.parse(response.body)

   expect(response.status).to eq(200)
   expect(output.count).to eq(2)
  end

  it 'finds a random item' do
   create(:item, name: 'cucumber')

   get '/api/v1/items/random.json'
   output = JSON.parse(response.body)

   expect(response.status).to eq(200)
   expect(output["name"]).to eq('cucumber')
  end

  it 'returns correct scope of json' do
   item = create(:item)
   get "/api/v1/items/#{item.id}.json"
   actual = JSON.parse(response.body)
   expected = {
     'id' => item.id,
     'name' => item.name,
     'description' => item.description,
     'unit_price' => '%.2f' % (item.unit_price / 100.0),
     'merchant_id' => item.merchant_id
   }

   expect(actual).to eq(expected)
  end

  it 'returns the correct price' do
   item = create(:item, unit_price: 1567280)
   get "/api/v1/items/#{item.id}.json"
   actual = JSON.parse(response.body)

   expect(actual['unit_price']).to eq('15672.80')
  end

  it 'returns a collection of associated invoice items' do
   item = create(:item)
   invoice_items = create_list(:invoice_item, 3, item_id: item.id, unit_price: 500)

   get "/api/v1/items/#{item.id}/invoice_items.json"
   actual = JSON.parse(response.body)

   expect(actual[0]['unit_price']).to eq("5.00")
   expect(actual.count).to eq(3)
  end

  it 'returns the associated merchant' do
   merchant = create(:merchant, name: 'Pierre')
   item = create(:item, merchant_id: merchant.id)

   get "/api/v1/items/#{item.id}/merchant.json"
   actual = JSON.parse(response.body)

   expect(actual['name']).to eq('Pierre')
  end

  it 'returns the date with the most sales for the given item using the invoice date' do
   item = create(:item)
   invoice1 = create(:invoice, created_at: '2012-03-23T10:55:29.000Z')
   invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, item_id: item.id, quantity: 2)
   create(:transaction, invoice_id: invoice1.id, result: 'success')
   invoice2 = create(:invoice, created_at: '2012-04-23T10:55:29.000Z')
   invoice_item2 = create(:invoice_item, invoice_id: invoice2.id, item_id: item.id)
   create(:transaction, invoice_id: invoice2.id, result: 'success')

   get "/api/v1/items/#{item.id}/best_day.json"
   actual = JSON.parse(response.body)

   expect(actual['best_day']).to eq('2012-03-23T10:55:29.000Z')
  end

  it 'returns the most recent day if the sales are tied' do
   item = create(:item)
   invoice1 = create(:invoice, created_at: '2012-03-23T10:55:29.000Z')
   invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, item_id: item.id, quantity: 2)
   create(:transaction, invoice_id: invoice1.id, result: 'success')
   invoice2 = create(:invoice, created_at: '2012-04-23T10:55:29.000Z')
   invoice_item2 = create(:invoice_item, invoice_id: invoice2.id, item_id: item.id, quantity: 2)
   create(:transaction, invoice_id: invoice2.id, result: 'success')

   get "/api/v1/items/#{item.id}/best_day.json"
   actual = JSON.parse(response.body)

   expect(actual['best_day']).to eq('2012-04-23T10:55:29.000Z')
  end

  it 'returns the top x item instances ranked by total number sold' do
    item1 = create(:item, name: 'Dude')
    invoice1 = create(:invoice)
    create(:invoice_item, invoice_id: invoice1.id, item_id: item1.id, quantity: 2)
    create(:transaction, invoice_id: invoice1.id, result: 'success')
    invoice2 = create(:invoice)
    create(:invoice_item, invoice_id: invoice2.id, item_id: item1.id)
    create(:transaction, invoice_id: invoice2.id, result: 'success')
    item2 = create(:item)
    invoice3 = create(:invoice)
    create(:invoice_item, invoice_id: invoice3.id, item_id: item2.id, quantity: 2)
    create(:transaction, invoice_id: invoice3.id, result: 'success')
    invoice4 = create(:invoice)
    create(:invoice_item, invoice_id: invoice4.id, item_id: item2.id)
    create(:transaction, invoice_id: invoice4.id, result: 'failed')
    item3 = create(:item)
    invoice4 = create(:invoice)
    create(:invoice_item, invoice_id: invoice4.id, item_id: item1.id, quantity: 1)
    create(:transaction, invoice_id: invoice4.id, result: 'success')

    get '/api/v1/items/most_items.json?quantity=2'
    actual = JSON.parse(response.body)

    expect(actual.count).to eq(2)
    expect(actual.first['name']).to eq('Dude')
  end
end
