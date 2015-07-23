class AddServiceEnabledToMenus < ActiveRecord::Migration
  def change
    change_table :menus do |t|
      t.boolean :service_enabled, default: true
    end
  end
end
