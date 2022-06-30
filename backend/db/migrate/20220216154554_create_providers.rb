class CreateProviders < ActiveRecord::Migration[7.0]
  def change
    create_table :providers do |t|
      t.string :provider
      t.string :uid
      t.string :user_name
      t.string :screen_name
      t.string :image_url
      t.references :user, null: false, foreign_key: true, index: { unique: true }

      t.timestamps
    end
  end
end
