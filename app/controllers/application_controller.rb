class ApplicationController < ActionController::API
  include SessionsConcern
  include BearerTokenConcern

  before_action :require_admin_login

  private

  # There are two authentication methods.
  # 1. use sorcery
  # 2. use bearer token in Authorization header.
  def require_admin_login
    if bearer_token?
      require_admin_login_by_bearer_token
    else
      require_admin_login_by_sorcery
    end
  end

  def bearer_token?
    return nil if !request.headers['Authorization']
    request.headers['Authorization'].start_with?('Bearer')
  end
end
