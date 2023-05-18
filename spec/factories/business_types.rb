# == Schema Information
#
# Table name: business_types
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_business_types_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :business_type do
    sequence(:name) { |n| "#{n}#{Faker::Lorem.word}" }

    initialize_with do
      BusinessType.find_by(name: attributes[:name]) || BusinessType.new(attributes)
    end
  end
end
