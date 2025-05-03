class CreateZipCodes < ActiveRecord::Migration[8.0]
  def change
    create_table :zip_codes do |t|
      t.string :code, limit: 5, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
