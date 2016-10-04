require 'rails_helper'

RSpec.describe 'Items API' do
 it 'returns a list of items' do
   create_list(:item, 3)

   get '/api/v1/items'
   output = JSON.parse(response.body)

   expect(response.status).to eq(200)
   expect(output.count).to eq(3)
 end
 
 it 'returns a single item' do
   item = create(:item, name: 'cucumber')
   
   get "/api/v1/items/#{item.id}"
   output = JSON.parse(response.body)

   expect(response.status).to eq(200)
   expect(output["name"]).to eq('cucumber')
 end

 it 'finds an item by name' do
   create(:item, name: 'cucumber', description: 'green')

   get '/api/v1/items/find?name=cucumber'
   output = JSON.parse(response.body)

   expect(response.status).to eq(200)
   expect(output["description"]).to eq('green')
 end

 it 'finds multiple items by name' do
   create_list(:item, 2, name: 'cucumber')

   get '/api/v1/items/find_all?name=cucumber'
   output = JSON.parse(response.body) 

   expect(response.status).to eq(200)
   expect(output.count).to eq(2)
 end


end
