# == Schema Information
#
# Table name: work_space_amenities
#
#  id                             :bigint           not null, primary key
#  description                    :text
#  name                           :string           not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  work_space_amenity_category_id :bigint
#
# Indexes
#
#  index_work_space_amenities_on_name                            (name) UNIQUE
#  index_work_space_amenities_on_work_space_amenity_category_id  (work_space_amenity_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (work_space_amenity_category_id => work_space_amenity_categories.id)
#
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
