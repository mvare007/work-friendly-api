class ReviewBlueprint < ApplicationBlueprint
  fields :rating, :comment, :user_id, :business_id

  view :extended do
    excludes :user_id, :business_id
    association :user, blueprint: UserBlueprint
    association :business, blueprint: BusinessBlueprint
  end

  fields :created_at, :updated_at
end
