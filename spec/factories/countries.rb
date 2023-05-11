FactoryBot.define do
  factory :country do
    name { Faker::Address.country }
    currency { Faker::Currency.code }
    dialing_code { Faker::PhoneNumber.subscriber_number(length: 3) }
    iso_code { Faker::Address.country_code }

    initialize_with do
      Country.find_by(name: attributes[:name]) || Country.new(attributes)
    end
  end
end
