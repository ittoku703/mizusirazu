class RenameTableAccountToUser < ActiveRecord::Migration[7.0]
  def change
    rename_table :accounts, :users
  end
end
