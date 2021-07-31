require 'rails_helper'

RSpec.describe "StaticPagesController", type: :request do
  describe "GET root" do
    it "request success" do
      get root_path
      expect(response.status).to eq 200
    end
  end

  describe "GET help" do
    it "request success" do
      get help_path
      expect(response.status).to eq 200
    end
  end

  describe "GET about" do
    it "request success" do
      get about_path
      expect(response.status).to eq 200
    end
  end

  describe "GET contact" do
    it "request success" do
      get contact_path
      expect(response.status).to eq 200
    end
  end

  describe "GET games" do
    it "request success" do
      get games_path
      expect(response.status).to eq 200
    end
  end
end
