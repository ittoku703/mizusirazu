require 'rails_helper'

RSpec.describe ProvidersController, type: :request do

  # skip GET /auth/:provider/callback test

  describe 'GET /auth/failure' do
    before do
      get provider_failure_path()
    end

    it 'redirect to root' do
      expect(response).to redirect_to root_path
    end
  end
end
