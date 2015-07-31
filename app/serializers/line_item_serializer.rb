class LineItemSerializer < ActiveModel::Serializer
  attributes  :id, :qty, :cost
  has_one :drink

  def cost
    object.cost_total
  end
end
