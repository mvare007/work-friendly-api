# == Schema Information
#
# Table name: bookings
#
#  id            :bigint           not null, primary key
#  end_time      :datetime         not null
#  start_time    :datetime         not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#  work_space_id :bigint           not null
#
# Indexes
#
#  index_bookings_on_user_id        (user_id)
#  index_bookings_on_work_space_id  (work_space_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (work_space_id => work_spaces.id)
#
class Booking < ApplicationRecord
  # Enums
  enum status: { pending: 0, confirmed: 1, cancelled: 2 }

  # Associations
  belongs_to :user
  belongs_to :work_space

  # Validations
  validates :status, presence: true, inclusion: { in: statuses.keys }
  validates :start_time, :end_time, presence: true
  validate :start_time_cannot_be_in_the_past, if: -> { start_time.present? }
  validate :end_time_cannot_be_in_the_past, if: -> { end_time.present? }
  validate :start_time_cannot_be_after_end_time, if: -> { start_time.present? && end_time.present? }

  # Scopes
  scope :for_business, ->(business_id) { joins(:work_space).where(work_spaces: { business_id: }) }
  scope :for_user, ->(user_id) { where(user_id:) }

  def confirm!
    update(status: :confirmed)
  end

  def cancel!
    update(status: :cancelled)
  end

  def price
    (end_time - start_time) * work_space.price_per_hour
  end

  private

  def start_time_cannot_be_in_the_past
    errors.add(:start_time, 'must be in the future') if start_time < DateTime.now
  end

  def end_time_cannot_be_in_the_past
    errors.add(:end_time, 'must be in the future') if end_time < DateTime.now
  end

  def start_time_cannot_be_after_end_time
    errors.add(:start_time, 'must be before end time') if start_time > end_time
  end
end
