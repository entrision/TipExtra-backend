class BraintreeCreatePaymentMethodJob < ActiveJob::Base
  queue_as :default

  def perform(user, nonce)
    result = Braintree::PaymentMethod.create(
      customer_id: user.braintree_customer_id,
      payment_method_nonce: nonce
    )

    if result.success?
      user.braintree_payment_method_token = result.payment_method.token
      user.save!
    else
      p result.errors
    end
  end
end
