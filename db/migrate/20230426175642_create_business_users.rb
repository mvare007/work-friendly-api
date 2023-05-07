class CreateBusinessUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :business_users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.boolean :admin, null: false, default: false
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end
