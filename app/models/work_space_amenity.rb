# == Schema Information
#
# Table name: work_space_amenities
#
#  id                             :bigint           not null, primary key
#  description                    :text
#  name                           :string           not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  work_space_amenity_category_id :bigint
#
# Indexes
#
#  index_work_space_amenities_on_name                            (name) UNIQUE
#  index_work_space_amenities_on_work_space_amenity_category_id  (work_space_amenity_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (work_space_amenity_category_id => work_space_amenity_categories.id)
#
class WorkSpaceAmenity < ApplicationRecord
  # Associations
  belongs_to :work_space_amenity_category, optional: true
  has_and_belongs_to_many :work_space_amenities

  # Validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
