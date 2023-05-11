class CreateCountries < ActiveRecord::Migration[7.0]
  def change
    create_table :countries do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :iso_code
      t.string :currency
      t.integer :dialing_code

      t.timestamps
    end
  end
end
