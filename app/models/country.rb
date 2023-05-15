# == Schema Information
#
# Table name: countries
#
#  id           :bigint           not null, primary key
#  active       :boolean          default(FALSE), not null
#  currency     :string
#  dialing_code :string
#  iso2_code    :string
#  iso3_code    :string
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_countries_on_name  (name) UNIQUE
#
class Country < ApplicationRecord
  # Associations
  has_many :cities, dependent: :destroy
  has_many :businesses, through: :cities

  # Validations
  validates :name, presence: true, length: { maximum: 255 }, uniqueness: true

  def timezones
    TZInfo::Country.get(iso2_code)&.zones
  end
end
