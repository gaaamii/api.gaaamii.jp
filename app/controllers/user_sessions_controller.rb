class UserSessionsController < ActionController::Base
  include SessionsConcern

  def ping
    if admin?
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
