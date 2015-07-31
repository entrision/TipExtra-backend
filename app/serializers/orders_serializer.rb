class OrdersSerializer < ActiveModel::Serializer
  attributes :id, :drink_total, :order_total, :customer_name

  def customer_name
    "#{object.user.first_name} #{object.user.last_name}"
  end

  def drink_total
    object.drink_total
  end

  def order_total
    object.total
  end
end
