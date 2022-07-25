class AddDeliveryTypeToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :delivery_type, :string
  end
end
