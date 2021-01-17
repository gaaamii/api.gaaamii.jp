class ApplicationController < ActionController::API
  include ActionView::Layouts
  before_action :require_admin_login

  ADMIN_USER_EMAIL = 'i1shi4ga4mi1@gmail.com'

  def require_admin_login
    head :unauthorized if @current_user && @current_user.email == ADMIN_USER_EMAIL 
  end
end
