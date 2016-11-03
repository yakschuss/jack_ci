class DashboardController < ApplicationController
  def show
    @user = current_user
    @repos = @user.repos.ordered_by_active
  end
end
