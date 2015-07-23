class OrderSerializer < ActiveModel::Serializer
  attributes :id, :order_total
  has_many :line_items

  def order_total
    object.total
  end
end
