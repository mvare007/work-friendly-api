class CreateCountries < ActiveRecord::Migration[7.0]
  def change
    create_table :countries do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :iso2_code
      t.string :iso3_code
      t.string :currency
      t.string :dialing_code
      t.boolean :active, default: false, null: false

      t.timestamps
    end
  end
end
