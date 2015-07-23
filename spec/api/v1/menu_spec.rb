require 'rails_helper'

describe Api::V1::MenusController, type: :api do
  let!(:user)   { create(:user) }
  let!(:menu)   { create(:menu, user: user) }
  let!(:drink1) { create(:drink, menu: menu) }
  let!(:drink2) { create(:drink, menu: menu) }
  let!(:drink3) { create(:drink, menu: menu) }
  let(:serialized_drink1) { JSON.parse(DrinkSerializer.new(drink1).to_json) }
  let(:serialized_drink2) { JSON.parse(DrinkSerializer.new(drink2).to_json) }
  let(:serialized_drink3) { JSON.parse(DrinkSerializer.new(drink3).to_json) }

  before { header_login user }

  describe 'GET show' do
    before { get "/api/v1/menus/#{menu.id}" }

    it 'returns success status' do
      expect(last_response.status).to eq(200)
    end

    it 'returns menu drinks' do
      expect(json["menu"]["drinks"]).to include(serialized_drink1["drink"], serialized_drink2["drink"], serialized_drink3["drink"])
    end
  end

  describe 'GET index' do
    let(:serialized_menu) { JSON.parse(MenusSerializer.new(menu).to_json) }
    before { get "api/v1/menus" }

    it 'returns success status' do
      expect(last_response.status).to eq(200)
    end

    it 'returns menus' do
      expect(json["menus"]).to include(serialized_menu["menus"])
    end
  end

  describe 'PATCH update' do
    context 'as the menu owner' do
      before { patch "/api/v1/menus/#{menu.id}", menu: { service_enabled: false } }

      it 'returns success status' do
        expect(last_response.status).to eq(200)
      end

      it 'updates the menu' do
        expect(menu.reload.service_enabled).to eq(false)
      end
    end

    context 'not the menu owner' do
      let(:user2) { create(:user) }
      before do
        header_login user2
        patch "/api/v1/menus/#{menu.id}", menu: { service_enabled: false }
      end

      it 'returns invalid status' do
        expect(last_response.status).to eq(403)
      end

      it 'returns error message' do
        expect(json["errors"]["message"]).to eq('Access Denied')
      end
    end
  end
end
