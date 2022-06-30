class AddLastUsedToAddresses < ActiveRecord::Migration[6.1]
  def change
    add_column :addresses, :last_used, :datetime
  end
end
