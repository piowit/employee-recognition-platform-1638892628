class FixEmployeeReceiverColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :kudos, :employee_id, :giver_id
  end
end
