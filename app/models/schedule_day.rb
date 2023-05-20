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
  TIME_FORMAT = '%H:%M'.freeze

  # Associations
  belongs_to :business

  # Validations
  validates :holiday, inclusion: { in: [true, false] }
  validates :holiday_name, length: { maximum: 255 }
  validates :weekday, presence: true, inclusion: { in: 0..6 }, unless: :holiday?
  validates :holiday_name, presence: true, if: :holiday?

  scope :for_business, ->(business_id) { where(business_id:) }

  def to_s
    "#{holiday ? holiday_name : weekday_name} #{open_time} - #{close_time}"
  end

  def weekday_name
    I18n.t('date.day_names')[weekday]
  end

  def open_time
    super&.strftime(TIME_FORMAT)
  end

  def close_time
    super&.strftime(TIME_FORMAT)
  end
end
