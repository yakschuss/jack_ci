require "rails_helper"

RSpec.describe PagesController, type: :controller do
  describe "#index" do
    it "returns a status 200" do
      get :index
      expect(response).to have_http_status(200)
    end
  end
end
