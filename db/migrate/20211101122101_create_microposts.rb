class CreateMicroposts < ActiveRecord::Migration[6.1]
  def change
    create_table :microposts do |t|
      t.string :title
      t.text :content
      t.references :user

      t.timestamps
    end
  end
end
