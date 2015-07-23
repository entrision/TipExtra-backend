class LineItemSerializer < ActiveModel::Serializer
  attributes  :drink_id, :qty, :cost

  def drink_id
    object.drink.id
  end

  def cost
    object.cost_total
  end
end
