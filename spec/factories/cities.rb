FactoryBot.define do
  factory :city do
    name { Faker::Address.city }
    active { true }

    association :country, strategy: :create

    initialize_with do
      City.find_by(name: attributes[:name]) || City.new(attributes)
    end
  end
end
