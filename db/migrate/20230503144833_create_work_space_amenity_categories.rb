class CreateWorkSpaceAmenityCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :work_space_amenity_categories do |t|
      t.string :name, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
