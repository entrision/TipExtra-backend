require 'rails_helper'

describe Api::V1::BraintreeController, type: :api do
  before { header_login }

  describe 'GET /api/v1/client_token' do
    before { get "/api/v1/client_token" }

    it "returns success status" do
      expect(last_response.status).to eq(200)
    end

    it "returns a token" do
      expect(json["token"]).to be_present
    end
  end

  describe 'POST /api/v1/payment_nonce' do
    before { post "api/v1/payment_nonce", { payment: { nonce: 'fake-valid-nonce' } } }

    it 'returns success status' do
      expect(last_response.status).to eq(201)
    end
  end
end
