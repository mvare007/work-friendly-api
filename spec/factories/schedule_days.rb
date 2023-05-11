FactoryBot.define do
  factory :schedule_day do
    sequence(:weekday, (0..6).cycle)
    open_time { Time.parse('08:00') }
    close_time { open_time + 12.hours }
    holiday { false }

    trait :holiday do
      holiday { true }
      holiday_name { Faker::Lorem.word }
      open_time { nil }
      close_time { nil }
    end

    association :business, strategy: :create

    initialize_with do
      ScheduleDay.find_by(business_id: attributes[:business_id]) || ScheduleDay.new(attributes)
    end
  end
end
