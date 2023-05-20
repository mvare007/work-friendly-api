class BookingBlueprint < ApplicationBlueprint
  fields :start_time, :end_time, :status, :business_id, :user_id

  view :extended do
    excludes :business_id, :user_id
    association :business, blueprint: BusinessBlueprint
    association :user, blueprint: UserBlueprint
  end

  fields :created_at, :updated_at
end
