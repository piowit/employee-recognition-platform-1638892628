class IndexOnReceiver < ActiveRecord::Migration[6.1]
  def change
    add_index :kudos, :receiver_id
  end
end
