class ContrainNullFalseOnOrdersSnapshot < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:orders, :snapshot, false)
  end
end
