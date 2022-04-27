require 'rails_helper'

RSpec.describe StaticPagesController, type: :request do
  describe 'GET /contact' do
    before do
      get contact_path()
    end

    it { it_should_be_success() }
  end

  describe 'POST /contact_post' do
    context 'valid params' do
      before do
        post contact_post_path(), params: { contact: { reply_email: 'valid@email.com', content: 'hello!' } }
      end

      it { it_send_deliver_later_email() }
      it { it_redirect_to(root_path()) }
    end

    context 'invalid params' do
      before do
        post contact_post_path(), params: { contact: { reply_email: 'invalid@email', content: '' } }
      end

      it { it_no_send_email() }
      it { it_render(:contact) }
    end
  end
end
