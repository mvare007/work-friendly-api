# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  address                :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  last_name              :string           not null
#  phone_number           :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  status                 :integer          default("0"), not null
#  zip_code               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  city_id                :bigint           not null
#
# Indexes
#
#  index_users_on_city_id               (city_id)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
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
    password { Faker::Internet.password(min_length: 12, max_length: 20, mix_case: true, special_characters: true) }
    address { Faker::Address.street_address }
    zip_code { Faker::Address.zip_code }

    association :city, strategy: :create

    after :create do |user|
      client_app = Doorkeeper::Application.find_by(name: 'Web Client')
      DoorkeeperService::AccessTokenCreator.call(user, client_app)
    end

    initialize_with do
      User.find_by(email: attributes[:email]) || User.new(attributes)
    end
  end
end
