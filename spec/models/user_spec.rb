require "rails_helper"

RSpec.describe User, type: :model do
  describe ".from_omniauth" do
    let(:info_hash) do
      double(
        nickname: "yakschuss",
        name: "jack",
        email: "email@email.com",
      )
    end
    let(:credentials_hash) do
      double(
        token: "random_token",
      )
    end

    let(:auth) do
      double(
        provider: "github",
        uid: "1224253",
        info: info_hash,
        credentials: credentials_hash,
      )
    end

    context "when a matching user exists" do
      it "loads the record" do
        user = User.create!(
          username: "username",
          first_name: "aName",
          email: "random@email.com",
          password: "password",
          provider: "github",
          uid: 1224253,
        )
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
