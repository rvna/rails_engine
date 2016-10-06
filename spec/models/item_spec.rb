require 'rails_helper'

RSpec.describe Item, type: :model do
  it 'returns the best selling day for an item' do
    item = create(:item)
    invoice1 = create(:invoice, created_at: '2012-03-23T10:55:29.000Z')
    invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, item_id: item.id, quantity: 2)
    create(:transaction, invoice_id: invoice1.id, result: 'success')
    invoice2 = create(:invoice, created_at: '2012-04-23T10:55:29.000Z')
    invoice_item2 = create(:invoice_item, invoice_id: invoice2.id, item_id: item.id)
    create(:transaction, invoice_id: invoice2.id, result: 'success')

    actual = item.best_day

    expect(actual).to eq('2012-03-23T10:55:29.000Z')
  end

  it 'returns the most recent of best days' do
    item = create(:item)
    invoice1 = create(:invoice, created_at: '2012-03-23T10:55:29.000Z')
    invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, item_id: item.id, quantity: 2)
    create(:transaction, invoice_id: invoice1.id, result: 'success')
    invoice2 = create(:invoice, created_at: '2012-04-23T10:55:29.000Z')
    invoice_item2 = create(:invoice_item, invoice_id: invoice2.id, item_id: item.id, quantity: 2)
    create(:transaction, invoice_id: invoice2.id, result: 'success')

    actual = item.best_day

    expect(actual).to eq('2012-04-23T10:55:29.000Z')
  end

  it 'returns the top x items ranked by total revenue generated' do
    item1 = create(:item, name: 'headphones')
    invoice1 = create(:invoice)
    invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, item_id: item1.id, unit_price: 100)
    create(:transaction, invoice_id: invoice1.id, result: 'success')
    item2 = create(:item, name: 'waterbottle')
    invoice2 = create(:invoice)
    invoice_item2 = create(:invoice_item, invoice_id: invoice2.id, item_id: item2.id, unit_price: 50)
    create(:transaction, invoice_id: invoice2.id, result: 'success')
    item3 = create(:item, name: 'shoe')
    invoice3 = create(:invoice)
    invoice_item3 = create(:invoice_item, invoice_id: invoice3.id, item_id: item3.id, unit_price: 75)
    create(:transaction, invoice_id: invoice3.id, result: 'success')

    result = Item.most_revenue(2)

    expect(result[0]['name']).to eq('headphones')
    expect(result[1]['name']).to eq('shoe')
    expect(result.length).to eq(2)
  end
end
