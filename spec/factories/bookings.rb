FactoryBot.define do
  factory :booking do
    start_time { Faker::Time.between(from: DateTime.now + 1, to: DateTime.now + 2) }
    end_time { Faker::Time.between(from: DateTime.now + 3, to: DateTime.now + 6) }

    association :user, strategy: :create
    association :work_space, strategy: :create
  end
end
