FactoryBot.define do
  factory :facility_amenity do
    sequence(:name) { |n| "#{n}#{Faker::Lorem.word}" }
    description { Faker::Lorem.sentence }

    association :facility_amenity_category, strategy: :create

    initialize_with do
      FacilityAmenity.find_by(facility_id: attributes[:facility_id],
                              amenity_id: attributes[:amenity_id]) || FacilityAmenity.new(attributes)
    end
  end
end
