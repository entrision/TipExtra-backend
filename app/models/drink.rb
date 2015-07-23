class Drink < ActiveRecord::Base
  belongs_to :menu
  has_one    :image,  dependent: :destroy
  has_many   :orders, through: :line_items

  validates_presence_of :name, :menu
end
