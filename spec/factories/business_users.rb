FactoryBot.define do
  factory :business_user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    association :business, strategy: :create

    trait :admin do
      admin { true }
    end
  end
end
