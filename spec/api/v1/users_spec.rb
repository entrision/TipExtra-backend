require 'rails_helper'

describe Api::V1::UsersController, type: :api do
  let!(:user) { create(:user) }
  before { header_login user }

  describe 'PATCH update' do
    context 'the logged in user' do
      before { patch "api/v1/users/#{user.id}", user: { first_name: 'Girl', last_name: 'Testwoman' } }

      it 'returns success status' do
        expect(last_response.status).to eq(200)
      end

      it 'updates the user' do
        expect(user.reload.first_name).to eq('Girl')
      end
    end

    context 'a different user' do
      let(:other_user) { create(:user) }

      before { patch "api/v1/users/#{other_user.id}" }

      it 'returns invalid status' do
        expect(last_response.status).to eq(403)
      end
    end

  end
end
