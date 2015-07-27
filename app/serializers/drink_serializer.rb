class DrinkSerializer < ActiveModel::Serializer
  attributes :id, :name, :price

  has_one :image, serializer: ImageSerializer
end
