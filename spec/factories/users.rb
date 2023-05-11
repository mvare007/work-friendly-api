FactoryBot.define do
  factory :user do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    sequence(:email) { |n| "#{n}#{Faker::Internet.email}" }
    password_digest { Faker::Internet.password }
    phone_number { Faker::PhoneNumber.phone_number }
    address { Faker::Address.street_address }
    zip_code { Faker::Address.zip_code }

    association :city, strategy: :create

    initialize_with do
      User.find_by(email: attributes[:email]) || User.new(attributes)
    end
  end
end
