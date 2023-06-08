# == Schema Information
#
# Table name: users
#
#  id           :bigint           not null, primary key
#  address      :string
#  email        :string           not null
#  first_name   :string           not null
#  last_login   :datetime
#  last_name    :string           not null
#  phone_number :string
#  status       :integer          default("0"), not null
#  zip_code     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  city_id      :bigint           not null
#
# Indexes
#
#  index_users_on_city_id  (city_id)
#  index_users_on_email    (email) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (city_id => cities.id)
#
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
