require "rails_helper"
require "pull_request"
require "task_runner"

RSpec.describe BuildJob do
  let(:pull_request) do
    {
      clone_url: "https://github.com/yakschuss/test_ruby_repo.git",
      repo_name: "test_ruby_repo",
      uid: "3080999",
      full_name: "yakschuss/test_ruby_repo",
      branch_name: "new_spec",
    }
  end

  describe "#perform" do
    it "kicks off a build" do
      BuildJob.new(pull_request).perform

      expect(TaskRunner).to receive(:run_build)
    end
  end
end
