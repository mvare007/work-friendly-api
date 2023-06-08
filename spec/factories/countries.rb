# == Schema Information
#
# Table name: countries
#
#  id           :bigint           not null, primary key
#  active       :boolean          default("false"), not null
#  currency     :string
#  dialing_code :string
#  iso2_code    :string
#  iso3_code    :string
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_countries_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :country do
    name { Faker::Address.country }
    currency { Faker::Currency.code }
    dialing_code { Faker::PhoneNumber.subscriber_number(length: 3) }
    iso2_code { Faker::Address.country_code }
    iso3_code { Faker::Address.country_code_long }

    initialize_with do
      Country.find_by(name: attributes[:name]) || Country.new(attributes)
    end
  end
end
