# == Schema Information
#
# Table name: work_spaces
#
#  id             :bigint           not null, primary key
#  available_from :time
#  available_to   :time
#  capacity       :integer
#  is_available   :boolean          default(TRUE), not null
#  name           :string
#  price_per_hour :decimal(, )
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  business_id    :bigint           not null
#
# Indexes
#
#  index_work_spaces_on_business_id           (business_id)
#  index_work_spaces_on_business_id_and_name  (business_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (business_id => businesses.id)
#
class WorkSpace < ApplicationRecord
  # Associations
  belongs_to :business
  has_and_belongs_to_many :work_space_amenities
  has_many :bookings, dependent: :restrict_with_error

  # Scopes
  scope :for_business, ->(business_id) { where(business_id: business_id) }

  # Validations
  validates :name, presence: true, uniqueness: { scope: :business_id }, length: { maximum: 255 }
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :price_per_hour, presence: true, numericality: { greater_than: 0 }
  validates :is_available, inclusion: { in: [true, false] }
end
