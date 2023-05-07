# == Schema Information
#
# Table name: business_users
#
#  id          :bigint           not null, primary key
#  admin       :boolean          default(FALSE), not null
#  first_name  :string           not null
#  last_name   :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  business_id :bigint           not null
#
# Indexes
#
#  index_business_users_on_business_id  (business_id)
#
# Foreign Keys
#
#  fk_rails_...  (business_id => businesses.id)
#
class BusinessUser < ApplicationRecord
	# Associations
	belongs_to :business

	# Validations
	validates :first_name, :last_name, presence: true, length: { maximum: 255 }
	validates :admin, inclusion: { in: [true, false] }
end
