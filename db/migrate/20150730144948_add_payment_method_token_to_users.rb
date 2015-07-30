class AddPaymentMethodTokenToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :braintree_payment_method_token
    end
  end
end
