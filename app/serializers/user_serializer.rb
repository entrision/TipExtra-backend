class UserSerializer < ActiveModel::Serializer
  attributes :name, :email, :authentication_token
end
