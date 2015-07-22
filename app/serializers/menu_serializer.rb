class MenuSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :drinks
end
