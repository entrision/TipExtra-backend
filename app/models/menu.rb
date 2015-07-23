class Menu < ActiveRecord::Base
  has_many :drinks
  belongs_to :user

  validates_presence_of :user
end
