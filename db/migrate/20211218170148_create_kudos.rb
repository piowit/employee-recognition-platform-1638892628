class CreateKudos < ActiveRecord::Migration[6.1]
  def change
    create_table :kudos do |t|
      t.string :title
      t.text :content
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
