class BraintreeTransactionJob < ActiveJob::Base
  queue_as :default

  def perform(order)
    result = Braintree::Transaction.sale(
      customer_id: order.user.braintree_customer_id,
      amount: order.total
    )

    if result.success?
      Rails.logger.error  "Transaction processed for order #{order.id}"

      true
    else
      result.errors.each do |err|
        Rails.logger.error "Unable to create Payment Method: #{err.message}"
      end

      false
    end
  end
end
