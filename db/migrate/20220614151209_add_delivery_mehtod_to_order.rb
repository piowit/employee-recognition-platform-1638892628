class AddDeliveryMehtodToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :delivery_method, :string, default: 'online', null: false
    add_column :orders, :address_snapshot, :text
  end
end
