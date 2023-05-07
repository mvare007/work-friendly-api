class CreateJoinTableBusinessFacilityAmenity < ActiveRecord::Migration[7.0]
  def change
    create_join_table :businesses, :facility_amenities do |t|
      t.index %i[business_id facility_amenity_id], name: 'index_bus_fac_amenities_on_bus_id_and_fac_amenity_id'
      t.index %i[facility_amenity_id business_id], name: 'index_bus_fac_amenities_on_fac_amenity_id_and_bus_id'
    end
  end
end
