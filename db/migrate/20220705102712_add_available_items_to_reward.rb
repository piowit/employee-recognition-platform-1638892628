class AddAvailableItemsToReward < ActiveRecord::Migration[6.1]
  def change
    add_column :rewards, :available_items, :integer, default: 0
  end
end
