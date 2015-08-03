class BraintreeCreateCustomerJob < ActiveJob::Base
  queue_as :default

  def perform(user)
    result = Braintree::Customer.create(
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email
    )

    if result.success?
      user.braintree_customer_id = result.customer.id
      user.save!
    else
      p result.errors
    end
  end
end
