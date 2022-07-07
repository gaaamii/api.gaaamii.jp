module SessionsConcern
  private

  def require_admin_login_by_sorcery
    head :unauthorized unless admin?
  end

  def admin?
    current_user && current_user.admin?
  end
end
