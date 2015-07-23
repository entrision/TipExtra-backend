require 'rails_helper'

describe Api::V1::SessionsController, type: :api do
  let!(:user) { create(:user) }

  describe "POST /api/v1/sessions" do
    context 'with valid data' do
      before do
        post '/api/v1/sessions', user: { email:    user.email,
                                        password: user.password }
      end

      it "returns a successful status" do
        expect(last_response.status).to eq(200)
      end

      it "returns auth token" do
        expect(json["user"]["authentication_token"]).to eq(user.reload.authentication_token)
      end
    end

    context 'with invalid data' do
      before do
        post '/api/v1/sessions', user: { email:    "nope@doesntexist.com",
                                        password: user.password }
      end

      it 'returns invalid status' do
        expect(last_response.status).to eq(401)
      end

      it 'returns error message' do
        expect(json["errors"]["login"]).to include('Invalid email or password')
      end
    end
  end

  describe "DELETE /api/v1/sessions" do
    before do
      header_login user
      delete '/api/v1/sessions'
    end

    it 'returns successful status' do
      expect(last_response.status).to eq(204)
    end

    it "removes user's auth token" do
      expect(user.reload.authentication_token).to be_nil
    end
  end
end
