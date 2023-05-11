# == Schema Information
#
# Table name: countries
#
#  id           :bigint           not null, primary key
#  currency     :string
#  dialing_code :integer
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
end
