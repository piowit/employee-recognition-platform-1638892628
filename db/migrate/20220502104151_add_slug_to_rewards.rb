class AddSlugToRewards < ActiveRecord::Migration[6.1]
  def change
    add_column :rewards, :slug, :string
  end
end
