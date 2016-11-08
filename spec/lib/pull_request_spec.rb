require "spec_helper"
require "pull_request"

RSpec.describe PullRequest do
  let(:data) do
    {
      "repository" => {
        "clone_url" => "https://github.com/yakschuss/test_ruby_repo.git",
        "name" => "test_ruby_repo",
      },
      "pull_request" => {
        "head" => {
          "ref" => "new_spec",
          "sha" => "string",
          "repo" => {
            "full_name" => "yakschuss/test_ruby_repo",
          },
        },
        "user" => {
          "id" => "3820999",
        },
      },
    }
  end

  describe ".build_data" do
    it "returns a hash" do
      pull_request = PullRequest.build_data(data)

      expect(pull_request).to be_a(Hash)
    end

    it "returns the clone url" do
      pull_request = PullRequest.build_data(data)

      expect(pull_request[:clone_url]).
        to eq("https://github.com/yakschuss/test_ruby_repo.git")
    end

    it "returns the repo name" do
      pull_request = PullRequest.build_data(data)

      expect(pull_request[:repo_name]).
        to eq("test_ruby_repo")
    end

    it "returns the branch name" do
      pull_request = PullRequest.build_data(data)

      expect(pull_request[:branch_name]).
        to eq("new_spec")
    end

    it "returns the sha" do
      pull_request = PullRequest.build_data(data)

      expect(pull_request[:sha]).
        to eq("string")
    end

    it "returns the full_name" do
      pull_request = PullRequest.build_data(data)

      expect(pull_request[:full_name]).
        to eq("yakschuss/test_ruby_repo")
    end

    it "returns the uid" do
      pull_request = PullRequest.build_data(data)

      expect(pull_request[:uid]).
        to eq("3820999")
    end
  end
end
