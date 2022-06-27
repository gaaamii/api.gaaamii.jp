class User < ApplicationRecord
  authenticates_with_sorcery!

  def admin?
    email == ENV["ADMIN_USER_EMAIL"]
  end
end
