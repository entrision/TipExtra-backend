class User < ActiveRecord::Base
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, presence: true

  after_create :braintree_create_customer

  #has_many :drinks, through: :orders
  has_many :orders, dependent: :destroy

  def braintree_update_card(card_stuff)
  end

  def braintree_add_card(credit_card)
    result = Braintree::Customer.update(
      self.braintree_customer_id,
      credit_card: {
        number: credit_card[:number],
        cvv:    credit_card[:cvv],
        expiration_month: credit_card[:expiration_month],
        expiration_year: credit_card[:expiration_year],
        cardholder_name: credit_card[:cardholder_name]
      }
    )
    unless result.success?
      p result.errors
    end
  end

  def braintree_remove_card(card_stuff)
  end

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
