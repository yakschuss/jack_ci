class GithubClient
  def initialize(user, client = Octokit::Client)
    @user = user
    @_client = client
  end

  def populate_user_repos
    response = get_user_repos
    response.each do |repo|
      Repo.
        find_or_create_by!(
          user: user,
          name: repo["name"],
          full_name: repo["full_name"],
        )
    end
  end

  private

  attr_reader :user

  def get_user_repos
    client.repositories(user.uid.to_i)
  end

  def client
    @_client ||= client.new(access_token: ENV["ACCESS_TOKEN"])
  end
end
