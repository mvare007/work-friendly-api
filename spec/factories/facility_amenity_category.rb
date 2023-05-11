FactoryBot.define do
  factory :facility_amenity_category do
    sequence(:name) { |n| "#{n}#{Faker::Lorem.word}" }

    initialize_with do
      FacilityAmenityCategory.find_by(name: attributes[:name]) || FacilityAmenityCategory.new(attributes)
    end
  end
end
