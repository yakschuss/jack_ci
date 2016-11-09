class PullRequest
  class << self
    def build_data(data)
      {
        clone_url: clone_url(data),
        repo_name: repo_name(data),
        branch_name: branch_name(data),
        sha: sha(data),
        full_name: full_name(data),
        uid: user_id(data),
      }
    end

    private

    def user_id(data)
      data.
        fetch("pull_request").
        fetch("user").
        fetch("id")
    end

    def clone_url(data)
      data.
        fetch("repository").
        fetch("clone_url")
    end

    def repo_name(data)
      data.
        fetch("repository").
        fetch("name")
    end

    def branch_name(data)
      data.
        fetch("pull_request").
        fetch("head").
        fetch("ref")
    end

    def full_name(data)
      data.
        fetch("pull_request").
        fetch("head").
        fetch("repo").
        fetch("full_name")
    end

    def sha(data)
      data.
        fetch("pull_request").
        fetch("head").
        fetch("sha")
    end
  end
end
