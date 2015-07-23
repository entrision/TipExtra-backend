require 'rails_helper'

RSpec.describe LineItem, type: :model do
  it { is_expected.to belong_to(:order) }
  it { is_expected.to belong_to(:drink) }

  describe '#cost_total' do
    let!(:drink)    { create(:drink, price: 750) }
    let!(:line_item) { create(:line_item, drink: drink, qty: 5) }

    it 'totals the cost' do
      expect(line_item.cost_total).to eq(3750)
    end
  end
end
