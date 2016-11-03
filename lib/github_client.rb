class GithubClient
  def initialize(user, client = Octokit::Client.new(
    access_token: ENV["ACCESS_TOKEN"],
  ))
    @user = user
    @client = client
  end

  def populate_user_repos
    response = get_user_repos
    response.each do |repo|
      Repo.find_or_create_by!(
        user: user,
        name: repo["name"],
        full_name: repo["full_name"],
        active: false,
      )
    end
  end

  def toggle_webhook(repo)
    if repo.active?
      turn_webhook_off(repo)
    else
      turn_webhook_on(repo)
    end
    repo.toggle_active
  end

  private

  attr_reader :user, :client

  def get_user_repos
    client.repositories(user.uid.to_i)
  end

  def turn_webhook_on(repo)
    response = client.create_hook(
      repo.full_name.to_s,
      "web",
      {
        url: "to-be-replaced-ngrok",
        content_type: "json",
      },
      events: ["push", "pull_request"],
      active: true,
    )
    repo.update_attributes(hook_id: response[:id])
  end

  def turn_webhook_off(repo)
    client.remove_hook(repo.full_name, repo.hook_id)
  end
end
