# == Schema Information
#
# Table name: businesses
#
#  id               :bigint           not null, primary key
#  address          :string           not null
#  capacity         :integer
#  email            :string           not null
#  latitude         :string
#  longitude        :string
#  name             :string           not null
#  phone_number     :string
#  vat_number       :string
#  zip_code         :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  business_type_id :bigint           not null
#  city_id          :bigint           not null
#
# Indexes
#
#  index_businesses_on_business_type_id  (business_type_id)
#  index_businesses_on_city_id           (city_id)
#  index_businesses_on_email             (email) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (business_type_id => business_types.id)
#  fk_rails_...  (city_id => cities.id)
#
class Business < ApplicationRecord
  # Associations
  belongs_to :city
  belongs_to :business_type
  has_one :country, through: :city
  has_many :schedule_days, dependent: :destroy
  has_many :business_users, dependent: :destroy
  has_many :work_spaces, dependent: :destroy
  has_many :reviews, dependent: :restrict_with_error

  # Validations
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :name, :address, :zip_code, presence: true, length: { maximum: 255 }
  validates :capacity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
end
