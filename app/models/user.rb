class User < ActiveRecord::Base
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, presence: true

  after_create :braintree_create_customer

  has_many :orders, dependent: :destroy
  has_one :menu

  def braintree_create_payment_method(nonce)
    BraintreeCreatePaymentMethodJob.perform_later(self, nonce)
  end

  private

  def braintree_create_customer
    BraintreeCreateCustomerJob.perform_later self
  end
end
