class BraintreeTransactionJob < ActiveJob::Base
  queue_as :default

  def perform(order)
    result = Braintree::Transaction.sale(
      customer_id: order.user.braintree_customer_id,
      amount: order.total
    )

    if result.success?
      p "Transaction processed for order #{order.id}"
      true
    else
      p result.errors
      false
    end
  end
end
