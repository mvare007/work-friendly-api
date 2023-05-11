FactoryBot.define do
  factory :work_space_amenity do
    sequence(:name) { |n| "#{n}#{Faker::Lorem.word}" }
    description { Faker::Lorem.sentence }
    association :work_space_amenity_category, strategy: :create

    initialize_with do
      WorkSpaceAmenity.find_by(name: attributes[:name]) || WorkSpaceAmenity.new(attributes)
    end
  end
end
