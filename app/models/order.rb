class Order < ActiveRecord::Base
  belongs_to :user
  has_many :drinks,     through: :line_items
  has_many :line_items, dependent: :destroy

  accepts_nested_attributes_for :line_items
  validates_presence_of :user

  def total
    cost = 0
    self.line_items.each { |i| cost = cost + i.cost_total }
    cost
  end

  def drink_total
    total = 0
    self.line_items.each { |i| total = total + i.qty }
    total
  end
end
