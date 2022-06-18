class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.references :employee, null: false, foreign_key: true
      t.string :street, null: false
      t.string :postcode, null: false
      t.string :city, null: false

      t.timestamps
    end
  end
end
