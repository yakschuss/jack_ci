require "spec_helper"
require "task_runner"

RSpec.describe TaskRunner do
  let(:request) do
    {
      clone_url: "https://github.com/yakschuss/test_ruby_repo.git",
      repo_name: "test_ruby_repo",
      branch_name: "new_spec",
    }
  end

  describe ".run_build" do
  end
end
