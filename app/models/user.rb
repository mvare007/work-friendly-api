# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  address         :string
#  email           :string           not null
#  first_name      :string           not null
#  last_login      :datetime
#  last_name       :string           not null
#  password_digest :string           not null
#  payment_info    :string
#  phone_number    :string
#  zip_code        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  city_id         :bigint           not null
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
class User < ApplicationRecord
  encrypts :payment_info

  # Associations
  belongs_to :city
  has_many :reviews, dependent: :restrict_with_error
  has_many :bookings, dependent: :restrict_with_error

  # Validations
  validates :first_name, :last_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :password_digest, presence: true, length: { maximum: 255 }
  validates :address, :zip_code, :phone_number, length: { maximum: 255 }
  validates :payment_info, length: { maximum: 255 }
end
