class CreateJoinTableWorkSpaceWorkSpaceAmenity < ActiveRecord::Migration[7.0]
  def change
    create_join_table :work_spaces, :work_space_amenities do |t|
      t.index %i[work_space_id work_space_amenity_id], name: 'index_ws_ws_amenities_on_ws_id_and_ws_amenity_id'
      t.index %i[work_space_amenity_id work_space_id], name: 'index_ws_ws_amenities_on_ws_amenity_id_and_ws_id'
    end
  end
end
