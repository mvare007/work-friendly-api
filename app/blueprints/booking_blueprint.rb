class BookingBlueprint < ApplicationBlueprint
  fields :start_time, :end_time, :status, :work_space_id, :user_id

  view :extended do
    excludes :work_space_id, :user_id
    association :work_space, blueprint: WorkSpaceBlueprint
    association :user, blueprint: UserBlueprint
  end

  fields :created_at, :updated_at
end
