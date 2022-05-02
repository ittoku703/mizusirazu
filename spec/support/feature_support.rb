module FeatureSupport
  def log_in_as(user)
    user.activate
    visit new_session_path()
    fill_in 'session[name_or_email]', with: user.name
    fill_in 'session[password]', with: 'password'
    click_button I18n.t('sessions.new_form.submit')
  end

  def activate_as(user)
    visit new_account_activation_path()
    fill_in 'account_activation[email]', with: user.email
    click_button I18n.t('account_activations.new_form.send_email')
    expect(page).to have_selector 'div#notice'
    visit activation_email_link
    log_in_as(user)
  end

  def activation_email_link
    activation_email = ActionMailer::Base.deliveries.last
    email_body = activation_email.body.parts.first.body
    reg_url = %r{http://localhost:3000/confirms/[\w=%.?/-]*}
    email_body.match(reg_url).to_s
  end

  def password_reset_email_link
    activation_email = ActionMailer::Base.deliveries.last
    email_body = activation_email.body.parts.first.body
    reg_url = %r{http://localhost:3000/passwords/[\w=%.?/-]*}
    email_body.match(reg_url).to_s
  end

  def fill_in_rich_text_area(locator = nil, with:)
    find(:rich_text_area, locator).execute_script("this.editor.loadHTML(arguments[0])", with.to_s)
  end
end

Capybara.add_selector :rich_text_area do
  label "rich-text area"
  xpath do |locator|
    if locator.nil?
      XPath.descendant(:"trix-editor")
    else
      input_located_by_name = XPath.anywhere(:input).where(XPath.attr(:name) == locator).attr(:id)

      XPath.descendant(:"trix-editor").where \
        XPath.attr(:id).equals(locator) |
        XPath.attr(:placeholder).equals(locator) |
        XPath.attr(:"aria-label").equals(locator) |
        XPath.attr(:input).equals(input_located_by_name)
    end
  end
end
