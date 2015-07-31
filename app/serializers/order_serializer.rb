class OrderSerializer < ActiveModel::Serializer
  attributes :id, :order_total, :customer_name
  has_many :line_items

  def customer_name
    "#{object.user.first_name} #{object.user.last_name}"
  end

  def order_total
    object.total
  end
end
