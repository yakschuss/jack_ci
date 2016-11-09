require "github_client"
require "pull_request"

class WebhookController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:handle_pull_request]
  skip_before_action :authenticate_user!, only: [:handle_pull_request]

  def toggle_pull_request_webhook
    repo = Repo.find(params[:repo])
    user = repo.user
    GithubClient.new(nil, Octokit::Client.new(
                            access_token: user.github_access_token,
    )).toggle_webhook(repo)
  end

  def handle_pull_request
    if params["pull_request"]
      BuildJob.new(PullRequest.build_data(params)).delay.perform
    end
  end
end
