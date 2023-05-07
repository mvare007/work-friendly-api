# == Schema Information
#
# Table name: reviews
#
#  id          :bigint           not null, primary key
#  comment     :text
#  rating      :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  business_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_reviews_on_business_id  (business_id)
#  index_reviews_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (business_id => businesses.id)
#  fk_rails_...  (user_id => users.id)
#
class Review < ApplicationRecord
  # Associations
  belongs_to :business
  belongs_to :user

  # Validations
  validates :rating, presence: true, numericality: {
    only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5
  }
  validates :comment, length: { maximum: 1000 }

  scope :for_business, ->(business_id) { where(business_id:) }
  scope :for_user, ->(user_id) { where(user_id:) }

  def to_s
    comment
  end
end
