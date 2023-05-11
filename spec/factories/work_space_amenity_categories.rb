FactoryBot.define do
	factory :work_space_amenity_category do
		sequence(:name) { |n| "#{n}#{Faker::Lorem.word}" }

		initialize_with do
			WorkSpaceAmenityCategory.find_by(name: attributes[:name]) || WorkSpaceAmenityCategory.new(attributes)
		end
	end
end