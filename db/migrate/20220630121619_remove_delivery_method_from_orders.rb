class RemoveDeliveryMethodFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :delivery_method, :string, default: 'online', null: false
  end
end
