class ApplicationController < ActionController::API
  include SessionsConcern
  before_action :require_admin_login
end
