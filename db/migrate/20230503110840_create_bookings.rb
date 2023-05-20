class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :work_space, null: false, foreign_key: true
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.integer :status, default: 0, null: false
      t.index %i[user_id work_space_id start_time end_time], unique: true, name: 'index_bookings_on_user_id_and_work_space_id_and_start_time_and_end_time'

      t.timestamps
    end
  end
end
