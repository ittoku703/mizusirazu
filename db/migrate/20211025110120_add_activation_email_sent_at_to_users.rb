class AddActivationEmailSentAtToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :activation_email_sent_at, :datetime
  end
end
