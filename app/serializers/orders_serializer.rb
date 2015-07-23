class OrdersSerializer < ActiveModel::Serializer
  attributes :id, :drink_total, :order_total

  def drink_total
    object.drink_total
  end

  def order_total
    object.total
  end
end
