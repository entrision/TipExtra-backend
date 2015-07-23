class User < ActiveRecord::Base
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, presence: true

  after_create :braintree_create_customer

  has_many :orders, dependent: :destroy
  has_one :menu

  private

  def braintree_create_customer
    result = Braintree::Customer.create(
      first_name: self.first_name,
      last_name: self.last_name,
      email: self.email
    )
    if result.success?
      self.braintree_customer_id = result.customer.id
      save!
    else
      p result.errors
    end
  end
end
