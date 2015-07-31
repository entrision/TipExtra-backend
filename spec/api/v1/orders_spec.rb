require 'rails_helper'

describe Api::V1::OrdersController, type: :api do
  let!(:user)   { create(:user) }
  let!(:order1) { create(:order, user: user) }
  let!(:order2) { create(:order, user: user) }
  let!(:item1)  { create(:line_item, order: order1) }
  let!(:item2)  { create(:line_item, order: order1) }
  let(:serialized_order1) { JSON.parse(OrdersSerializer.new(order1).to_json) }
  let(:serialized_order2) { JSON.parse(OrdersSerializer.new(order2).to_json) }
  let(:serialized_item1)  { JSON.parse(LineItemSerializer.new(item1).to_json) }
  let(:serialized_item2)  { JSON.parse(LineItemSerializer.new(item2).to_json) }

  before { header_login user }

  describe 'GET index' do
    before { get "/api/v1/orders" }

    it 'returns success status' do
      expect(last_response.status).to eq(200)
    end

    it 'returns orders' do
      expect(json["orders"]).to include(serialized_order1["orders"], serialized_order2["orders"])
    end
  end

  describe 'GET show' do
    context 'correct user' do
      before { get "/api/v1/orders/#{order1.id}" }

      it 'returns success status' do
        expect(last_response.status).to eq(200)
      end

      it 'returns order information' do
        expect(json["order"]["line_items"]).to include(serialized_item1["line_item"], serialized_item2["line_item"])
      end
    end

    context 'incorrect user' do
      let(:other_user) { create(:user) }
      before do
        header_login other_user
        get "/api/v1/orders/#{order1.id}"
      end

      it 'returns unsuccessful status' do
        expect(last_response.status).to eq(403)
      end

      it 'returns error message' do
        expect(last_response.body).to include('Access Denied')
      end
    end
  end

  describe 'POST create' do
    let!(:drink1) { create(:drink) }
    let!(:drink2) { create(:drink) }
    let!(:drink3) { create(:drink) }

    before do
      post "/api/v1/orders", order: {
        line_items_attributes: [
          { drink_id: drink1.id, qty: 1 },
          { drink_id: drink2.id, qty: 2 },
          { drink_id: drink3.id, qty: 1 }
        ]
      }
    end

    context 'with valid data' do
      it 'returns success status' do
        expect(last_response.status).to eq(201)
      end

      it 'returns the new order data' do
        expect(json["order"]["line_items"][0].keys).to eq(li_return_fields)
      end
    end

    context 'with invalid data' do
      before do
        post "/api/v1/orders", order: {
          line_items_attributes: [
            { drink_id: nil, qty: 2 },
            { drink_id: nil, qty: 1 }
          ]
        }
      end

      it 'returns invalid status' do
        expect(last_response.status).to eq(422)
      end

      it 'returns error message' do
        expect(last_response.body['errors']).not_to be_blank
      end
    end

    context 'menu service disabled' do
      let!(:menu) { create(:menu, service_enabled: false) }
      let!(:drink1) { create(:drink, menu: menu) }

      before do
        post "/api/v1/orders", order: {
          line_items_attributes: [
            { drink_id: drink1.id, qty: 2 }
          ]
        }
      end

      it 'returns invalid status' do
        expect(last_response.status).to eq(422)
      end

      it 'returns error message' do
        expect(last_response.body['errors']).not_to be_blank
      end
    end
  end

  def li_return_fields
    ['id', 'qty', 'cost', 'drink']
  end
end
