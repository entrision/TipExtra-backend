class CreateDrinks < ActiveRecord::Migration
  def change
    create_table :drinks do |t|
      t.string :name
      t.integer :price
      t.belongs_to :menu, index: true

      t.timestamps null: false
    end
  end
end
