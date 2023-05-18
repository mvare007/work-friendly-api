# == Schema Information
#
# Table name: facility_amenities
#
#  id                           :bigint           not null, primary key
#  description                  :text
#  name                         :string           not null
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  facility_amenity_category_id :bigint
#
# Indexes
#
#  index_facility_amenities_on_facility_amenity_category_id  (facility_amenity_category_id)
#  index_facility_amenities_on_name                          (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (facility_amenity_category_id => facility_amenity_categories.id)
#
class FacilityAmenity < ApplicationRecord
  # Associations
  belongs_to :facility_amenity_category, optional: true
  has_many :business_facility_amenities, dependent: :destroy

  # Validations
  validates :name, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :description, length: { maximum: 1000 }
end
