class CreateWorkSpaceAmenities < ActiveRecord::Migration[7.0]
  def change
    create_table :work_space_amenities do |t|
      t.string :name, null: false, index: { unique: true }
      t.text :description
      t.references :work_space_amenity_category, foreign_key: true

      t.timestamps
    end
  end
end
