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
