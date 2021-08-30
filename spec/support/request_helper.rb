module RequestHelper
  def login_admin
    # @request.env["devise.mapping"] = Devise.mappings[:admin]
    sign_in FactoryBot.create(:admin)
  end

  def login_user
    # @request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryBot.create(:user)
    user.confirm
    sign_in user
  end

  def email_clear = ActionMailer::Base.deliveries.clear
end
