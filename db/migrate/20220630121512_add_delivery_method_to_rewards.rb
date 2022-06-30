class AddDeliveryMethodToRewards < ActiveRecord::Migration[6.1]
  def change
    add_column :rewards, :delivery_method, :string, default: 'online', null: false
  end
end
