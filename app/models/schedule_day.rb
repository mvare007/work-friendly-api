# == Schema Information
#
# Table name: schedule_days
#
#  id           :bigint           not null, primary key
#  close_time   :time
#  holiday      :boolean
#  holiday_name :string
#  open_time    :time
#  weekday      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  business_id  :bigint           not null
#
# Indexes
#
#  index_schedule_days_on_business_id  (business_id)
#
# Foreign Keys
#
#  fk_rails_...  (business_id => businesses.id)
#
class ScheduleDay < ApplicationRecord
  # Associations
  belongs_to :business

  # Validations
  validates :weekday, presence: true, inclusion: { in: 0..6 }
  validates :open_time, presence: true
  validates :close_time, presence: true
  validates :holiday, inclusion: { in: [true, false] }
  validates :holiday_name, length: { maximum: 255 }

  def weekday_name
    I18n.t('date.day_names')[weekday]
  end
end
