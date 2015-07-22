require 'rails_helper'

describe Api::V1::MenusController, type: :api do
  let!(:menu)   { create(:menu) }
  let!(:drink1) { create(:drink, menu: menu) }
  let!(:drink2) { create(:drink, menu: menu) }
  let!(:drink3) { create(:drink, menu: menu) }
  let(:serialized_drink1) { JSON.parse(DrinkSerializer.new(drink1).to_json) }
  let(:serialized_drink2) { JSON.parse(DrinkSerializer.new(drink2).to_json) }
  let(:serialized_drink3) { JSON.parse(DrinkSerializer.new(drink3).to_json) }

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
end
