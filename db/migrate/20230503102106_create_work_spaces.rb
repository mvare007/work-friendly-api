class CreateWorkSpaces < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    create_table :work_spaces do |t|
      t.string :name
      t.integer :capacity
      t.decimal :price_per_hour
      t.time :available_from
      t.time :available_to
      t.boolean :is_available, null: false, default: true
      t.references :business, null: false, foreign_key: true

      t.index %i[business_id name], unique: true

      t.timestamps
    end
  end
end
