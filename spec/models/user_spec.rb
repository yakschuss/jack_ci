require "rails_helper"

RSpec.describe User, type: :model do
  describe ".from_omniauth" do
    let(:info_hash) { double(nickname: "yakschuss", name: "jack", email: "email@email.com") }
    let(:auth) { double(provider: "github", uid: "1224253", info: info_hash) }

    context "when a matching user exists" do
      it "loads the record" do
        user = User.create!(email: "random@email.com", password: "password", provider: "github", uid: 1224253)
        result = User.from_omniauth(auth)
        expect(result).to eq(user)
        expect(result.email).to eq("random@email.com")
      end
    end

    context "when no matching user exists" do
      it "creates a new user" do
        expect { User.from_omniauth(auth) }.to change(User, :count).by(1)
      end
    end
  end
end
