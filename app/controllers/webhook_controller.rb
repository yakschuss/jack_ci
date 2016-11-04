require "github_client"
class WebhookController < ApplicationController
  def toggle_pull_request_webhook
    repo = Repo.find(params[:repo])
    user = repo.user
    GithubClient.new(nil, Octokit::Client.new(
                            access_token: user.github_access_token,
    )).toggle_webhook(repo)
  end
end
