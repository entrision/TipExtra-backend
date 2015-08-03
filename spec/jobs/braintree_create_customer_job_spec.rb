require 'rails_helper'

RSpec.describe BraintreeCreateCustomerJob, type: :job do
  let!(:user) { create(:user) }

  it 'assigns braintree_customer_id to user' do

    VCR.use_cassette('braintree_create_customer') do
      BraintreeCreateCustomerJob.perform_now user
      expect(user.reload.braintree_customer_id).to be_present
    end

  end

end
