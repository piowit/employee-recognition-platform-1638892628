class ChangeNameOfSnapshot < ActiveRecord::Migration[6.1]
  def change
    rename_column :orders, :snapshot, :reward_snapshot
  end
end
