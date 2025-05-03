class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.string :line_1
      t.string :line_2
      t.string :city
      t.references :state, null: false, foreign_key: true
      t.references :zip_code, null: false, foreign_key: true

      t.timestamps
    end
  end
end
