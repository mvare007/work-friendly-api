class CreateScheduleDay < ActiveRecord::Migration[7.0]
  def change
    create_table :schedule_days do |t|
      t.integer :weekday
      t.time :open_time
      t.time :close_time
      t.boolean :holiday
      t.string :holiday_name
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end
