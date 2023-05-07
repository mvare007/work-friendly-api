# == Schema Information
#
# Table name: business_types
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class BusinessType < ApplicationRecord
  # Associations
  has_many :businesses, dependent: :restrict_with_error

  # Validations
  validates :name, presence: true
end
