# == Schema Information
#
# Table name: cities
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(FALSE), not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :bigint           not null
#
# Indexes
#
#  index_cities_on_country_id  (country_id)
#
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id)
#
class City < ApplicationRecord
  # Associations
  belongs_to :country
  has_many :businesses, dependent: :destroy
  has_many :users, dependent: :restrict_with_error

  # Validations
  validates :name, presence: true, length: { maximum: 255 }
  validates :active, inclusion: { in: [true, false] }
end
