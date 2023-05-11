# == Schema Information
#
# Table name: bookings
#
#  id            :bigint           not null, primary key
#  end_time      :datetime         not null
#  start_time    :datetime         not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#  work_space_id :bigint           not null
#
# Indexes
#
#  index_bookings_on_user_id        (user_id)
#  index_bookings_on_work_space_id  (work_space_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (work_space_id => work_spaces.id)
#
FactoryBot.define do
  factory :booking do
    start_time { Faker::Time.between(from: DateTime.now + 1, to: DateTime.now + 2) }
    end_time { Faker::Time.between(from: DateTime.now + 3, to: DateTime.now + 6) }

    association :user, strategy: :create
    association :work_space, strategy: :create
  end
end
