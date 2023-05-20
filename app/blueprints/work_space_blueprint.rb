class WorkSpaceBlueprint < ApplicationBlueprint
  fields :available_from, :available_to, :capacity, :is_available, :name, :price_per_hour, :business_id

  view :business do
    excludes :business_id
    association :business, blueprint: BusinessBlueprint
  end

  view :bookings do
    association :bookings, blueprint: BookingBlueprint
  end

  view :amenities do
    association :work_space_amenities, blueprint: WorkSpaceAmenityBlueprint
  end

  view :extended do
    include_view :business
    include_view :bookings
    include_view :amenities
  end

  fields :created_at, :updated_at
end
