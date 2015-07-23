class OrderSerializer < ActiveModel::Serializer
  attributes :id, :cost_total
  has_many :line_items

  def cost_total
    object.total
  end
end
