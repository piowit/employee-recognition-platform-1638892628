class CreateCategoryRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :category_rewards do |t|
      t.references :category, null: false, foreign_key: true
      t.references :reward, null: false, foreign_key: true

      t.timestamps
    end
  end
end
