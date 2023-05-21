class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.string :phone_number
      t.string :address
      t.string :zip_code
      t.string :payment_info
      t.datetime :last_login
      t.integer :status, default: 0, null: false

      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
