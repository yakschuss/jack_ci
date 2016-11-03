require "github_client"
require "spec_helper"
require "rails_helper"

class TestOctokit
  def self.repositories(_uid)
    [
      {
        "name" => "repo_name",
        "full_name" => "user_name/repo_name",
      },
    ]
  end

  def self.create_hook(*_repo)
    {
      type: "Repository",
      id: 10541623,
      name: "web",
      active: true,
    }
  end

  def self.remove_hook(*_repo)
    true
  end
end

RSpec.describe GithubClient do
  describe "#populate_user_repos" do
    context "when the repo doesn't exist" do
      it "it tells Repo to create with user's repos" do
        user = build(:user)

        expect { GithubClient.new(user, TestOctokit).populate_user_repos }.
          to change(Repo, :count).
          by(1)
      end
    end

    context "when the repo exists" do
      it "doesnt change the count" do
        user = create(:user)
        create(:repo, user: user)

        expect { GithubClient.new(user, TestOctokit).populate_user_repos }.
          to_not change(Repo, :count)
      end
    end
  end

  describe "#toggle_webhook" do
    context "when the repo is activated" do
      it "sends the create_hook message to Github" do
        user = build(:user)
        repo = build(:repo, user: user)

        response = { id: "1234" }
        expect(TestOctokit).
          to receive(:create_hook).
          with(any_args).
          and_return(response)

        GithubClient.new(user, TestOctokit).toggle_webhook(repo)
      end

      it "changes active from false to true" do
        user = build(:user)
        repo = build(:repo, user: user)

        GithubClient.new(user, TestOctokit).toggle_webhook(repo)

        expect(repo.active?).to eq(true)
      end

      it "saves the hook_id" do
        user = build(:user)
        repo = build(:repo, user: user)

        GithubClient.new(user, TestOctokit).toggle_webhook(repo)

        expect(repo.hook_id).to_not be_nil
      end
    end

    context "when the repo is deactivated" do
      it "sends the remove_hook message to Github" do
        user = build(:user)
        repo = build(:repo, active: true, user: user)

        expect(TestOctokit).to receive(:remove_hook).with(any_args)

        GithubClient.new(user, TestOctokit).toggle_webhook(repo)
      end

      it "changes active from true to false" do
        user = build(:user)
        repo = build(:repo, active: true, user: user)

        GithubClient.new(user, TestOctokit).toggle_webhook(repo)

        expect(repo.active?).to eq(false)
      end
    end
  end
end
