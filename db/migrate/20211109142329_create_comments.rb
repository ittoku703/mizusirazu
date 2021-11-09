class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :micropost_id
      t.text :content
      t.references :user

      t.timestamps
    end
  end
end
