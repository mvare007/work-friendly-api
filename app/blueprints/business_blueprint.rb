class BusinessBlueprint < ApplicationBlueprint
  fields :name, :address, :zip_code, :email, :phone_number, :vat_number, :latitude, :longitude, :capacity, :city_id,
         :business_type_id

  field :city_name do |business|
    business.city_name
  end

  field :business_type_name do |business|
    business.business_type_name
  end

  view :extended do
    association :schedule_days, blueprint: ScheduleDayBlueprint
    association :facility_amenities, blueprint: FacilityAmenityBlueprint
    association :social_links, blueprint: SocialLinkBlueprint
    association :work_spaces, blueprint: WorkSpaceBlueprint
  end

  fields :created_at, :updated_at
end
