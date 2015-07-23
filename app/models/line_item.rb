class LineItem < ActiveRecord::Base
  attr_accessor :drink_id

  belongs_to :order
  belongs_to :drink

  before_validation :associate_drink
  validates_presence_of :drink

  def cost_total
    self.drink.price * self.qty
  end

  private

  def associate_drink
    return if self.drink

    if self.drink_id
      drink = Drink.find(self.drink_id)
      self.drink = drink
    end
  end
end
