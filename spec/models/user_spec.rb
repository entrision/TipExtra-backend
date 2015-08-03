require 'rails_helper'

RSpec.describe User, type: [:model, :job] do
  it { is_expected.to have_many(:orders).dependent(:destroy) }
  it { is_expected.to have_one(:menu) }

  let!(:user) { create(:user) }

  describe "#create_payment_method" do
    it 'enqueues BraintreeCreatePaymentMethodJob' do
      expect{
        user.braintree_create_payment_method('a_payment_nonce')
      }.to enqueue_a(BraintreeCreatePaymentMethodJob).with(global_id(user), 'a_payment_nonce')
    end
  end

  describe 'creating a user' do
    let(:user) { build(:user) }

    it 'enqueues a braintree customer creation job' do
      expect{ user.save }.to enqueue_a(BraintreeCreateCustomerJob).with(global_id(user))
    end
  end
end
