class LineItemSerializer < ActiveModel::Serializer
  attributes :id, :qty, :drink_id

  def drink_id
    object.drink.id
  end
end
