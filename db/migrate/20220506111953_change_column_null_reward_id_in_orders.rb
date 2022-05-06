class ChangeColumnNullRewardIdInOrders < ActiveRecord::Migration[6.1]
  def change
    change_column_null :orders, :reward_id, true
  end
end
