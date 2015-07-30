require 'rails_helper'

describe Api::V1::MenuOrdersController, type: :api do
  let!(:user) { create(:user) }
  let!(:menu) { create(:menu, user: user) }
  let!(:drink1) { create(:drink, menu: menu) }
  let!(:drink2) { create(:drink, menu: menu) }
  let!(:line_item1) { create(:line_item, drink: drink1) }
  let!(:line_item2) { create(:line_item, drink: drink2) }
  let!(:order1) { create(:order, line_items: [line_item1]) }
  let!(:order2) { create(:order, line_items: [line_item2]) }
  let(:serialized_order1) { JSON.parse(OrdersSerializer.new(order1).to_json) }
  let(:serialized_order2) { JSON.parse(OrdersSerializer.new(order2).to_json) }
  let(:serialized_order_1) { JSON.parse(OrderSerializer.new(order1).to_json) }

  before { header_login user }

  describe 'GET /api/v1/menus/:menu_id/orders' do
    context 'as menu owner' do
      before { get "/api/v1/menus/#{menu.id}/orders" }

      it 'returns success status' do
        expect(last_response.status).to eq(200)
      end

      it 'returns order data' do
        expect(json["menu_orders"]).to include( serialized_order1['orders'], serialized_order2['orders'] )
      end
    end

    context 'as different user' do
      let(:user2) { create(:user) }

      before do
        header_login user2
        get "/api/v1/menus/#{menu.id}/orders"
      end

      it 'returns invalid status' do
        expect(last_response.status).to eq(403)
      end

      it 'returns errors message' do
        expect(json["errors"]["message"]).to include('Access Denied')
      end
    end
  end

  describe 'GET /api/v1/menus/:menu_id/orders/:id' do
    context 'as menu owner' do
      before { get "/api/v1/menus/#{menu.id}/orders/#{order1.id}" }

      it 'returns success status' do
        expect(last_response.status).to eq(200)
      end

      it 'returns order data' do
        expect(json["order"]).to include( serialized_order_1['order'] )
      end
    end

    context 'as different user' do
      let(:user2) { create(:user) }

      before do
        header_login user2
        get "/api/v1/menus/#{menu.id}/orders/#{order1.id}"
      end

      it 'returns invalid status' do
        expect(last_response.status).to eq(403)
      end

      it 'returns errors message' do
        expect(json["errors"]["message"]).to include('Access Denied')
      end
    end
  end


  describe 'PATCH /api/v1/menus/:menu_id/orders/:id' do
    context 'as memnu owner' do
      before { patch "/api/v1/menus/#{menu.id}/orders/#{order1.id}", order: { complete: true } }

      it 'returns success status' do
        expect(last_response.status).to eq(200)
      end

      it 'returns order data' do
        expect(json["order"]).to include( serialized_order_1['order'] )
      end

      it 'marks the order complete' do
        expect(Order.find(order1.id).complete).to be true
      end
    end

    context 'as different user' do
      let(:user2) { create(:user) }

      before do
        header_login user2
        patch "/api/v1/menus/#{menu.id}/orders/#{order1.id}", order: { complete: true }
      end

      it 'returns invalid status' do
        expect(last_response.status).to eq(403)
      end

      it 'returns errors message' do
        expect(json["errors"]["message"]).to include('Access Denied')
      end
    end
  end
end
