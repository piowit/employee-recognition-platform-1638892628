class AddPointsToEmployee < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :points, :integer, default: 0
  end
end
