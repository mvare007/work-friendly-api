class CreateSocialLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :social_links do |t|
      t.string :platform, null: false
      t.string :url, null: false
      t.references :business, null: false, foreign_key: true
      t.index %i[business_id platform], unique: true

      t.timestamps
    end
  end
end
