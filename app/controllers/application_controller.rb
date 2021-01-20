class ApplicationController < ActionController::API
  include ActionView::Layouts
  before_action :require_admin_login

  ADMIN_USER_EMAIL = 'i1shi4ga4mi1@gmail.com'

  private

  def admin?
    @current_user && @current_user.email == ADMIN_USER_EMAIL 
  end

  def require_admin_login
    head :unauthorized unless admin?
  end
end
