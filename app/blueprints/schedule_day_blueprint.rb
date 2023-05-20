class ScheduleDayBlueprint < ApplicationBlueprint
  field :open_time, datetime_format: ScheduleDay::TIME_FORMAT
  field :close_time, datetime_format: ScheduleDay::TIME_FORMAT
  field :weekday
  field :weekday_name do |schedule_day|
    schedule_day.weekday_name
  end
  field :holiday
  field :holiday_name
  field :business_id
  fields :created_at, :updated_at
end
