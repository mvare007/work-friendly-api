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
  # Enums
  enum status: { active: 0, inactive: 1, suspended: 2 }

  # Associations
  belongs_to :city
  belongs_to :business_type
  has_and_belongs_to_many :facility_amenities
  has_one :country, through: :city
  has_many :schedule_days, dependent: :destroy
  has_many :social_links, dependent: :destroy
  has_many :work_spaces, dependent: :destroy
  has_many :reviews, dependent: :restrict_with_error

  # Nested attributes
  accepts_nested_attributes_for :schedule_days, allow_destroy: true
  accepts_nested_attributes_for :social_links, allow_destroy: true

  # Delegates
  with_options prefix: true do
    delegate :name, to: :country
    delegate :name, to: :business_type
  end

  # Validations
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :name, :address, :zip_code, presence: true, length: { maximum: 255 }
  validates :capacity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  # Scopes
  scope :for_business_type, ->(business_type_id) { where(business_type_id:) }
end
