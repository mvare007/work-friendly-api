class CreateFacilityAmenities < ActiveRecord::Migration[7.0]
  def change
    create_table :facility_amenities do |t|
      t.string :name, null: false, index: { unique: true }
      t.text :description
      t.references :facility_amenity_category, foreign_key: true

      t.timestamps
    end
  end
end
