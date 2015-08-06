require 'rails_helper'

RSpec.describe BraintreeCreatePaymentMethodJob, type: :job do
  let!(:user) { create(:user, braintree_customer_id: 35979126) }

  context 'with a valid nonce' do
    it 'assigns braintree payment method id' do
      VCR.use_cassette('braintree_successful_create_payment_method') do
        BraintreeCreatePaymentMethodJob.perform_now(user, 'fake-valid-nonce')
        expect(user.reload.braintree_payment_method_token).to be_present
      end
    end
  end

  context 'with invalid nonce' do
    it 'does not create payment method token' do
      VCR.use_cassette('braintree_unsuccessful_create_payment_method') do
        BraintreeCreatePaymentMethodJob.perform_now(user, 'invalid-nonce')
        expect(user.reload.braintree_payment_method_token).not_to be_present
        #expect{
          #BraintreeCreatePaymentMethodJob.perform_now(user, 'invalid-nonce')
        #}.to raise_exception
      end
    end
  end
end
