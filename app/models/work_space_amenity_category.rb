# == Schema Information
#
# Table name: work_space_amenity_categories
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_work_space_amenity_categories_on_name  (name) UNIQUE
#
class WorkSpaceAmenityCategory < ApplicationRecord
  # Associations
  has_many :work_space_amenities, dependent: :nullify

  # Validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
