require 'rails_helper'

RSpec.describe 'Invoices API' do
  it 'returns a list of invoices' do
    create_list(:invoice, 3)
    get '/api/v1/invoices'
    output = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(output.count).to eq(3)
  end
end

