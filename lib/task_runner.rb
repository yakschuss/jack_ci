class TaskRunner
  class << self
    def run_build(request)
      test_result = nil

      clone_repo(request[:clone_url])

      Dir.chdir("tmp/#{request[:repo_name]}") do
        checkout_branch(request[:branch_url])

        bundle_install

        test_result = run_test
      end

      system("rm -rf tmp/#{request[:repo_name]}")

      test_result
    end

    private

    def bundle_install
      system("BUNDLE_GEMFILE=./Gemfile bundle install &> /dev/null")
    end

    def run_test
      system("BUNDLE_GEMFILE=./Gemfile rspec &> /dev/null")
    end

    def clone_repo(clone_url)
      system("cd tmp && git clone #{clone_url} &> /dev/null")
    end

    def checkout_branch(branch_name)
      system("git fetch && git checkout #{branch_name} &> /dev/null")
    end
  end
end
