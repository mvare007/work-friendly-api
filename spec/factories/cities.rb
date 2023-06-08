# == Schema Information
#
# Table name: cities
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :bigint           not null
#
# Indexes
#
#  index_cities_on_country_id  (country_id)
#
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id)
#
FactoryBot.define do
  factory :city do
    name { Faker::Address.city }

    association :country, strategy: :create

    initialize_with do
      City.find_by(name: attributes[:name]) || City.new(attributes)
    end
  end
end
