class AddSnpashotToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :snapshot, :text
  end
end
