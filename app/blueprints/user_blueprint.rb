class UserBlueprint < ApplicationBlueprint
  fields :first_name, :last_name, :email, :address, :zip_code, :phone_number, :city_id, :created_at, :updated_at

  view :city do
    exclude :city_id
    association :city, blueprint: CityBlueprint
  end

  view :reviews do
    association :reviews, blueprint: ReviewBlueprint
  end

  view :bookings do
    association :bookings, blueprint: BookingBlueprint
  end

  view :extended do
    include_view :city
    include_view :reviews
    include_view :bookings
  end
end
