# == Schema Information
#
# Table name: work_space_amenity_categories
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_work_space_amenity_categories_on_name  (name) UNIQUE
#
FactoryBot.define do
	factory :work_space_amenity_category do
		sequence(:name) { |n| "#{n}#{Faker::Lorem.word}" }

		initialize_with do
			WorkSpaceAmenityCategory.find_by(name: attributes[:name]) || WorkSpaceAmenityCategory.new(attributes)
		end
	end
end
