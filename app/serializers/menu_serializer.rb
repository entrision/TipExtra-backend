class MenuSerializer < ActiveModel::Serializer
  attributes :id, :name, :service_enabled
  has_many :drinks
end
