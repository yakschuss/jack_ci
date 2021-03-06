class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  private

  def after_sign_in_path_for(resource)
    dashboard_path(resource.id)
  end

  def after_sign_out_path_for(_resource)
    root_path
  end
end
