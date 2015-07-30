require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:orders).dependent(:destroy) }
  it { is_expected.to have_one(:menu) }

  let!(:user) { create(:user) }

  describe "#create_payment_method" do
    context 'with valid nonce' do
      it 'adds payment method to a BT customer' do
        user.braintree_create_payment_method('fake-valid-nonce')
        expect(user.reload.braintree_payment_method_token).to be_present
      end
    end

    context 'with invalid nonce' do
      it 'returns errors' do
        user.braintree_create_payment_method('fakeasdfasdfvnonce')
        expect(user.reload.braintree_payment_method_token).not_to be_present
      end
    end

  end
end
