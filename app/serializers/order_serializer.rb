class OrderSerializer < ActiveModel::Serializer
  attributes :id
  has_many :line_items
end
