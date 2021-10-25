class User < ApplicationRecord
  authenticates_with_sorcery!

  before_validation :downcase_email
  before_update :setup_activation, if: -> { email_changed? }
  after_update :send_activation_needed_email!, if: -> { previous_changes['email'].present? }

  NAME_REGEXP = /\A[\w+\-.\s]+\z/i
  EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true, format: { with: EMAIL_REGEXP }, length: { maximum: 255 }, uniqueness: true
  with_options if: -> { new_record? || changes[:crypted_password] } do
    validates :password, length: { in: 3..999 }, confirmation: true
    validates :password_confirmation, presence: true
  end

  def resend_activation_email!
    send_activation_needed_email!
  end

  private

  def downcase_email
    email.downcase!
  end
end
