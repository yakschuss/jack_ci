require "rails_helper"

RSpec.describe PagesController, type: :controller do
  let(:user) { User.create!(email: "email@email.com", password: "password") }

  describe "#index" do
    context "when a user is signed in" do
      it "returns a status 200" do
        sign_in user
        get :index
        expect(response).to have_http_status(200)
      end
    end

    context "when a user is unauthorized" do
      it "returns a status 302" do
        get :index
        expect(response).to have_http_status(302)
      end
    end
  end
end
