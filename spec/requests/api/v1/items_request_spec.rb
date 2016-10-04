require 'rails_helper'

RSpec.describe 'Items API' do
 it 'returns a list of items' do
   create_list(:item, 3)

   get '/api/v1/items'
   output = JSON.parse(response.body)

   expect(response.status).to eq(200)
   expect(output.count).to eq(3)
 end
end
