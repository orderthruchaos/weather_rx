class CreateZipCodes < ActiveRecord::Migration[8.0]
  def change
    create_table :zip_codes do |t|
      t.string :code, limit: 5

      t.timestamps
    end
    add_index :zip_codes, :code, unique: true
  end
end
