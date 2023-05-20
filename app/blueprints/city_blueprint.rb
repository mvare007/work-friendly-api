class CityBlueprint < ApplicationBlueprint
  field :name

  field :country_name do |object|
    object.country_name
  end

  field :country_id

  view :extended do
    excludes :country_id, :country_name
    association :country, blueprint: CountryBlueprint
  end

  fields :created_at, :updated_at
end
