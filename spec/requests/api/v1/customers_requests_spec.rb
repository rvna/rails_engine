require 'rails_helper'

describe 'customers endpoints functioning' do
  it 'returns JSON list of all customers' do
    create_list(:customer, 3)
    get '/api/v1/customers.json'
    customers = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(customers.count).to eq(3)
    expect(customers[0]['id']).to eq(Customer.first.id)
  end

  it 'returns JSON for specific customer' do
    expected = create(:customer, first_name: 'Dude')
    get "/api/v1/customers/#{expected.id}.json"
    actual = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(actual['id']).to eq(expected.id)
    expect(actual['first_name']).to eq('Dude')
  end

  it 'returns JSON for customer using find parameters' do
    expected = create(:customer, first_name: 'Dude')
    create(:customer, first_name: 'Dud')
    get '/api/v1/customers/find.json?first_name=Dude'
    actual = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(actual['id']).to eq(expected.id)
    expect(actual['first_name']).to eq('Dude')
    expect(actual['first_name']).to_not eq('Dud')
  end

  it 'returns JSON for all customers matching parameters' do
    create(:customer, first_name: 'Dude', last_name: 'Franklin')
    create(:customer, first_name: 'Dude', last_name: 'Workman')
    create(:customer, first_name: 'Hey', last_name: 'Workman')
    get '/api/v1/customers/find_all.json?last_name=Workman'
    actual = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(actual.count).to eq(2)
    expect(actual[1]['id']).to eq(Customer.last.id)
  end
  
  it 'returns JSON for a random customer' do
    expected = create(:customer)
    get "/api/v1/customers/random.json"
    actual = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(actual['id']).to eq(expected.id)
  end

  it 'returns correct scope of json' do
    customer = create(:customer)
    get "/api/v1/customers/#{customer.id}.json"
    actual = JSON.parse(response.body)
    expected = {
      'id' => customer.id,
      'first_name' => customer.first_name,
      'last_name' => customer.last_name
    }

    expect(actual).to eq(expected)
  end

  it 'returns a collection of associated invoices' do
    customer = create(:customer)
    invoices = create_list(:invoice, 3, customer_id: customer.id, status: 'success')

    get "/api/v1/customers/#{customer.id}/invoices.json"
    actual = JSON.parse(response.body)

    expect(actual[0]['status']).to eq('success')
    expect(actual.count).to eq(3)
  end
end
