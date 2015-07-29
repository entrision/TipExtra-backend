class AddCompleteFlagToOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.boolean :complete, default: false
    end
  end
end
