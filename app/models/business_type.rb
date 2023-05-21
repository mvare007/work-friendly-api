# == Schema Information
#
# Table name: business_types
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_business_types_on_name  (name) UNIQUE
#
class BusinessType < ApplicationRecord

  # Associations
  has_many :businesses, dependent: :restrict_with_error

  # Validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
