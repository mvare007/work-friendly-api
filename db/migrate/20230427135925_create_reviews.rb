class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :rating, null: false, default: 0
      t.text :comment
      t.references :user, null: false, foreign_key: true
      t.references :business, null: false, foreign_key: true
      t.index %i[business_id user_id], unique: true

      t.timestamps
    end
  end
end
