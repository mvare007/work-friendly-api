class CreateBusinesses < ActiveRecord::Migration[7.0]
  def change
    create_table :businesses do |t|
      t.string :name, null: false
      t.integer :capacity
      t.string :phone_number
      t.string :email, null: false, index: { unique: true }
      t.string :address, null: false
      t.string :zip_code, null: false
      t.string :vat_number
      t.string :longitude
      t.string :latitude
      t.references :city, null: false, foreign_key: true
      t.references :business_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
