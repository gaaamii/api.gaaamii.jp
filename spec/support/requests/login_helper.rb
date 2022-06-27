module Requests
  module LoginHelper
    def login(email, password)
      post user_sessions_path, params: { email: email, password: password}
    end
  end
end