# == Schema Information
#
# Table name: facility_amenity_categories
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_facility_amenity_categories_on_name  (name) UNIQUE
#
class FacilityAmenityCategory < ApplicationRecord
	# Associations
	has_many :facility_amenities, dependent: :nullify

	# Validations
	validates :name, presence: true, length: { maximum: 255 }, uniqueness: true
end
