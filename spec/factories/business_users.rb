# == Schema Information
#
# Table name: business_users
#
#  id          :bigint           not null, primary key
#  admin       :boolean          default(FALSE), not null
#  first_name  :string           not null
#  last_name   :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  business_id :bigint           not null
#
# Indexes
#
#  index_business_users_on_business_id  (business_id)
#
# Foreign Keys
#
#  fk_rails_...  (business_id => businesses.id)
#
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
