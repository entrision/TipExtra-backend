class BraintreeCreatePaymentMethodJob < ActiveJob::Base
  queue_as :default

  def perform(user, nonce)
    result = Braintree::PaymentMethod.create(
      customer_id: user.braintree_customer_id,
      payment_method_nonce: nonce,
      options: {
        make_default: true
      }
    )

    if result.success?
      user.braintree_payment_method_token = result.payment_method.token
      user.save!
    else
      result.errors.each do |err|
        Rails.logger.error "Unable to create Payment Method: #{err.message}"
      end
    end
  end
end
