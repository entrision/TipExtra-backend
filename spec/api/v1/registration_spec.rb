require 'rails_helper'

describe Api::V1::RegistrationsController, type: :api do
  describe 'POST /api/v1/users' do
    context 'with invalid data' do
      before do
        post "api/v1/users", user: { email: 'not_valid',
                                     name: '',
                                     password: 'dranksNshots' }
      end

      it 'returns invalid status' do
        expect(last_response.status).to eq(422)
      end

      it 'returns error message' do
        expect(json["errors"]["email"]).to include('is invalid')
        expect(json["errors"]["name"]).to  include("can't be blank")
      end
    end

    context 'with valid data' do
      before do
        post "api/v1/users", user: { email:    'guy@testman.com',
                                     name:     'Guy Testman',
                                     password: 'dranksNshots'}
      end

      it 'returns success status' do
        expect(last_response.status).to eq(201)
      end

      it 'returns newly created record' do
        expect(json["user"]["authentication_token"]).to be_present
        expect(json["user"]["name"]).to eq('Guy Testman')
      end
    end

  end
end
