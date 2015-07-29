class Menu < ActiveRecord::Base
  has_many :drinks
  belongs_to :user

  validates_presence_of :user

  def orders
    Order.joins(line_items: :drink).where("drinks.menu_id = #{self.id}").where(complete: false).uniq
  end
end
