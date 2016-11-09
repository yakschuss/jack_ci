require "github_client"
require "task_runner"

class BuildJob
  attr_reader :pull_request

  def initialize(pull_request)
    @pull_request = pull_request
  end

  def perform
    result = TaskRunner.run_build(pull_request)

    status_info = configure_response(result)

    client.send_repo_status(status_info)
  end

  private

  def client
    pull_request_user = User.find_by(uid: pull_request[:uid])

     GithubClient.new(
      pull_request_user,
      Octokit::Client.new(
        access_token: pull_request_user.github_access_token,
      ),
    )
  end

  def configure_response(result)
    options = {}
    status = result ? "success" : "failure"

    options[:context] = result ? "Ready To Merge" : "Failed"
    options[:description] = result ? "The Build Succeeded" : "The Build Failed"

    [full_name, sha, status, options]
  end

  def full_name
    pull_request[:full_name]
  end

  def sha
    pull_request[:sha]
  end
end
