# == Schema Information
#
# Table name: work_spaces
#
#  id             :bigint           not null, primary key
#  available_from :time
#  available_to   :time
#  capacity       :integer
#  is_available   :boolean          default("true"), not null
#  name           :string
#  price_per_hour :decimal(, )
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  business_id    :bigint           not null
#
# Indexes
#
#  index_work_spaces_on_business_id           (business_id)
#  index_work_spaces_on_business_id_and_name  (business_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (business_id => businesses.id)
#

FactoryBot.define do
  factory :work_space do
    sequence(:name)
    capacity { rand(1..12) }
    is_available { Faker::Boolean.boolean }
    price_per_hour { Faker::Commerce.price(range: 2.0..100.0) }

    association :business, strategy: :create

    initialize_with do
      WorkSpace.find_by(name: attributes[:name], business_id: attributes[:business_id]) || WorkSpace.new(attributes)
    end
  end
end
