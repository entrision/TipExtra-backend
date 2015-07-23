class AddUserIdToMenus < ActiveRecord::Migration
  def change
    change_table :menus do |t|
      t.integer :user_id
    end
  end
end
