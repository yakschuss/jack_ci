require "github_client"
require "spec_helper"
require "rails_helper"

class TestOctokit
  def self.repositories(_uid)
    [{ id: 1, "name" => "repo_name", "full_name" => "user_name/repo_name" }]
  end
end

RSpec.describe GithubClient do
  describe "#populate_user_repos" do
    context "when the repo doesn't exist" do
      it "it tells Repo to create with user's repos" do
        user = User.create!(email: "email@email.com", password: "password", uid: 11234154)
        expect { GithubClient.new(user, TestOctokit).populate_user_repos }.
          to change(Repo, :count).
          by(1)
      end
    end

    context "when the repo exists" do
      it "doesnt change the count" do
        user = User.create!(email: "email@email.com", password: "password", uid: 11234154)
        Repo.create!(user: user, name: "repo_name", full_name: "user_name/repo_name")

        expect { GithubClient.new(user, TestOctokit).populate_user_repos }.to_not change(Repo, :count)
      end
    end
  end
end
