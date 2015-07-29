require 'rails_helper'

describe Api::V1::BraintreeController, type: :api do
  before { header_login }

  describe 'get token' do
    before { get "/api/v1/client_token" }

    it "returns success status" do
      expect(last_response.status).to eq(200)
    end

    it "returns a token" do
      expect(json["token"]).to be_present
    end
  end
end
