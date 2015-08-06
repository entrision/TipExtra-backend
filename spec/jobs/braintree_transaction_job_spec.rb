require 'rails_helper'

RSpec.describe BraintreeTransactionJob, type: :job do
  let!(:user) { create(:user, braintree_customer_id: 35979126, braintree_payment_method_token: 'h8jm92' ) }
  let!(:order)  { create(:order, user: user) }
  let!(:drink) { create(:drink, price: 500) }
  let!(:line_item) { create(:line_item, drink: drink, qty: 2, order: order) }

  it 'returns success' do
    VCR.use_cassette('braintree_successful_transaction') do
      result = BraintreeTransactionJob.perform_now order
      expect(result).to be(true)
      #expect{ BraintreeTransactionJob.perform_now order }.to output(true)
    end
  end
end
