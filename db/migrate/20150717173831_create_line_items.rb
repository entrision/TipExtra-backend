class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.belongs_to :drink, index: true
      t.belongs_to :order, index: true
      t.integer :qty, default: 1

      t.timestamps null: false
    end
  end
end
