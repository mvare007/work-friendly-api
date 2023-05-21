class CityBlueprint < ApplicationBlueprint
  field :name

  field :country_name do |object|
    object.country_name
  end

  fields :country_id, :created_at, :updated_at
end
