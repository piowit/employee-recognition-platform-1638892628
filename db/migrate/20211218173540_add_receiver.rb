class AddReceiver < ActiveRecord::Migration[6.1]
  def change
    add_column :kudos, :receiver_id, :bigint, null: false
  end
end
