require "rails_helper"

RSpec.describe WebhookController, type: :controller do
  describe "#toggle_pull_request_webhook" do
    it "calls sends toggle_webhook to the GithubClient" do
      github_client = double(GithubClient)
      expect(github_client).to receive(:toggle_webhook)
    end
  end

  describe "#handle_pull_request" do
    it "it creates a delayed job instance" do
      build = BuildJob.new({})

      expect(build).to receive(:perform)

      post :handle_pull_request
    end
  end
end
