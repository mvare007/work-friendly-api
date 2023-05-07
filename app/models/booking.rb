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
  # Associations
  belongs_to :user
  belongs_to :work_space

  # Validations
  validates :start_time, :end_time, presence: true
  validate :booking_times, if: -> { start_time.present? && end_time.present? }

  private

  def booking_times
    errors.add(:start_time, 'must be before end time') if start_time > end_time
    errors.add(:start_time, 'must be in the future') if start_time < DateTime.now
    errors.add(:end_time, 'must be in the future') if end_time < DateTime.now
  end
end
