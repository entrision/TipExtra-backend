require 'rails_helper'

RSpec.describe Menu, type: :model do
  it { is_expected.to have_many(:drinks) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:user) }

  describe '#orders' do
    let!(:menu) { create(:menu) }
    let!(:drink1) { create(:drink, menu: menu) }
    let!(:drink2) { create(:drink, menu: menu) }
    let!(:line_item1) { create(:line_item, drink: drink1) }
    let!(:line_item2) { create(:line_item, drink: drink2) }
    let!(:line_item3) { create(:line_item, drink: drink2) }
    let!(:order1) { create(:order, line_items: [line_item1]) }
    let!(:order2) { create(:order, line_items: [line_item2]) }
    let!(:order3) { create(:order, line_items: [line_item3], complete: true) }

    it 'returns orders with drinks from this menu' do
      expect(menu.orders).to include(order1, order2)
    end

    it 'does not return completed orders' do
      expect(menu.orders).not_to include(order3)
    end
  end
end
