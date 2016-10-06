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
end
