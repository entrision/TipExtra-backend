class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :authentication_token, :braintree_customer_id
end
