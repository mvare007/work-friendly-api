FactoryBot.define do
	factory :business_type do
		sequence(:name) { |n| "#{n}#{Faker::Lorem.word}" }

		initialize_with do
			BusinessType.find_by(name: attributes[:name]) || BusinessType.new(attributes)
		end
	end
end