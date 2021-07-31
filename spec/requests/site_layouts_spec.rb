require 'rails_helper'

RSpec.describe "SiteLayouts", type: :request do
  describe 'GET /' do
    context 'non-logged-in user' do
      it "is correct site layouts" do
        get root_path
        assert_select "a[href=?]", root_path, count: 2
        assert_select "a[href=?]", help_path
        assert_select "a[href=?]", about_path
        assert_select "a[href=?]", contact_path
        assert_select "a[href=?]", new_user_registration_path
        assert_select "a[href=?]", new_user_session_path
      end
    end

    context 'logged-in user' do
      before_login_user

      it "is correct site layouts" do
        get root_path
        assert_select "a[href=?]", root_path, count: 2
        assert_select "a[href=?]", help_path
        assert_select "a[href=?]", about_path
        assert_select "a[href=?]", contact_path
        assert_select "a[href=?]", user_path
        assert_select "a[href=?]", edit_user_registration_path
        assert_select "a[href=?]", destroy_user_session_path
      end
    end
  end
end
