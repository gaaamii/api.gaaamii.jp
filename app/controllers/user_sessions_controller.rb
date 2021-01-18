class UserSessionsController < ApplicationController
  include ActionController::RequestForgeryProtection
  skip_before_action :require_admin_login

  def ping
    if 
      head :ok
    else
      head :unauthorized
    end
  end

  def new
    render action: :new
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      render plain: 'Login Successful as ' + @user.email
    else
      render plain: 'Login failed'
    end
  end

  def destroy
    logout
    render plain: 'Logout Successful'
  end
end
