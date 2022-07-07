class AddOnlineCodesCountToRewards < ActiveRecord::Migration[6.1]
  def self.up
    add_column :rewards, :online_codes_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :rewards, :online_codes_count
  end
end
