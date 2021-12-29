class ConstrainNullFalse < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:kudos, :title, false)
    change_column_null(:kudos, :content, false)
  end
end
