class WorkSpaceAmenityBlueprint < ApplicationBlueprint
  fields :name, :work_space_amenity_category_id, :created_at, :updated_at

  view :extended do
    exclude :work_space_amenity_category_id
    association :work_space_amenity_category, blueprint: WorkSpaceAmenityCategoryBlueprint
  end
end
