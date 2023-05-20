class FacilityAmenityBlueprint < ApplicationBlueprint
  fields :name, :facility_amenity_category_id, :created_at, :updated_at

  view :extended do
    exclude :facility_amenity_category_id
    association :facility_amenity_category, blueprint: FacilityAmenityCategoryBlueprint
  end
end
