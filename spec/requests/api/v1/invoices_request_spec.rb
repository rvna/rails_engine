require 'rails_helper'

RSpec.describe 'Invoices API' do
  it 'returns a list of invoices' do
    create_list(:invoice, 3)
    get '/api/v1/invoices'
    output = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(output.count).to eq(3)
  end
  
  it 'returns an individual invoice' do
    invoice = create(:invoice, status: 'shipped')
    get "/api/v1/invoices/#{invoice.id}"
    output = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(output["status"]).to eq('shipped')
  end
    
end

