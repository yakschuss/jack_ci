FactoryGirl.define do
  factory :repo do
    user
    name "repo_name"
    full_name "user_name/repo_name"
    active false
    hook_id nil
  end
end
