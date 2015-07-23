require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to have_many(:line_items).dependent(:destroy) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to accept_nested_attributes_for(:line_items) }

  it { is_expected.to validate_presence_of(:user) }

  describe "#total" do
    let!(:order)  { create(:order) }
    let!(:drink1) { create(:drink, price: 500) }
    let!(:drink2) { create(:drink, price: 1000) }
    let!(:line_item1) { create(:line_item, drink: drink1, qty: 2, order: order) }
    let!(:line_item2) { create(:line_item, drink: drink2, qty: 1, order: order) }

    it 'totals line item cost' do
      expect(order.total).to eq(2000)
    end
  end

  describe "#drink_total" do
    let!(:order)  { create(:order) }
    let!(:drink1) { create(:drink, price: 500) }
    let!(:drink2) { create(:drink, price: 1000) }
    let!(:line_item1) { create(:line_item, drink: drink1, qty: 2, order: order) }
    let!(:line_item2) { create(:line_item, drink: drink2, qty: 1, order: order) }

    it 'returns the total number of drinks' do
      expect(order.drink_total).to eq(3)
    end
  end
end
