FactoryBot.define do
  factory :review do
    rating { Faker::Number.between(from: 1, to: 5) }
    comment { Faker::Lorem.sentence }
    association :user, strategy: :create
    association :business, strategy: :create

    initialize_with do
      Review.find_by(user_id: attributes[:user_id],
                     business_id: attributes[:business_id]) || Review.new(attributes)
    end
  end
end
