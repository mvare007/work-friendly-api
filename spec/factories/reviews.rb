# == Schema Information
#
# Table name: reviews
#
#  id          :bigint           not null, primary key
#  comment     :text
#  rating      :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  business_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_reviews_on_business_id              (business_id)
#  index_reviews_on_business_id_and_user_id  (business_id,user_id) UNIQUE
#  index_reviews_on_user_id                  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (business_id => businesses.id)
#  fk_rails_...  (user_id => users.id)
#
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
