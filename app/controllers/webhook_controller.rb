require "github_client"
class WebhookController < ApplicationController
  def toggle_pull_request_webhook
    repo = Repo.find(params[:repo])
    GithubClient.new(nil).toggle_webhook(repo)
  end
end
