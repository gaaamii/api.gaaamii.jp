class ApplicationController < ActionController::API
  include ActionView::Layouts
  before_action :require_admin_login

  ADMIN_USER_EMAIL = ENV["ADMIN_USER_EMAIL"]

  private

  def admin?
    Rails.logger.info("@current_user")
    Rails.logger.info(@current_user)
    @current_user && @current_user.email == ADMIN_USER_EMAIL 
  end

  def require_admin_login
    head :unauthorized unless admin?
  end
end
