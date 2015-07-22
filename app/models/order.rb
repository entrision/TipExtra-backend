class Order < ActiveRecord::Base
  belongs_to :user
  has_many :drinks,     through: :line_items
  has_many :line_items, dependent: :destroy

  accepts_nested_attributes_for :line_items
  validates_presence_of :user
end
