# == Schema Information
#
# Table name: businesses
#
#  id               :bigint           not null, primary key
#  address          :string           not null
#  capacity         :integer
#  email            :string           not null
#  latitude         :string
#  longitude        :string
#  name             :string           not null
#  phone_number     :string
#  status           :integer          default("0"), not null
#  vat_number       :string
#  zip_code         :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  business_type_id :bigint           not null
#  city_id          :bigint           not null
#
# Indexes
#
#  index_businesses_on_business_type_id        (business_type_id)
#  index_businesses_on_city_id                 (city_id)
#  index_businesses_on_email                   (email) UNIQUE
#  index_businesses_on_longitude_and_latitude  (longitude,latitude)
#
# Foreign Keys
#
#  fk_rails_...  (business_type_id => business_types.id)
#  fk_rails_...  (city_id => cities.id)
#
FactoryBot.define do
  factory :business do
    name { Faker::Company.name }
    address { Faker::Address.street_address }
    zip_code { Faker::Address.zip_code }
    sequence(:email) { |n| "#{n}#{Faker::Internet.email}" }
    capacity { rand(0..12) }

    association :city, strategy: :create
    association :business_type, strategy: :create

    after(:build, :create) do |business|
      create_list(:schedule_day, 7, business:)
    end

    initialize_with do
      Business.find_by(email: attributes[:email]) || Business.new(attributes)
    end
  end
end
