class ImageSerializer < ActiveModel::Serializer
  attributes :image_url, :thumb_url

  def image_url
    object.image.url
  end

  def thumb_url
    object.image.thumb.url
  end
end
