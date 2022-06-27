module BearerTokenConcern
  include ActionController::HttpAuthentication::Token::ControllerMethods

  private

  # ref: https://firebase.google.com/docs/auth/admin/verify-id-tokens?hl=ja#verify_id_tokens_using_a_third-party_jwt_library
  ALG = 'RS256'
  CERTS_URI = URI('https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com')
  CERTS_CACHE_KEY = 'firebase_auth_certificates'
  PROJECT_ID = ENV["FIREBASE_AUTH_PROJECT_ID"]
  ISSUER_URI = "https://securetoken.google.com/#{PROJECT_ID}"

  def require_admin_login_by_bearer_token
    authenticate_or_request_with_http_token do |token|
      authenticate_token token
    end

    head :unauthorized unless @current_user.admin?
  end

  def authenticate_token(token)
    options = {
      algorithm: ALG,
      iss: ISSUER_URI,
      verify_iss: true,
      aud: PROJECT_ID,
      verify_aud: true,
      verify_iat: true,
    }

    payload, _ = JWT.decode(token, nil, true, options) do |header|
      cert = certificates[header['kid']]
      if cert.present?
        OpenSSL::X509::Certificate.new(cert).public_key
      else
        nil
      end
    end

    raise 'Invalid auth_time' unless Time.zone.at(payload['auth_time']).past?
    raise 'Invalid sub' if payload['sub'].empty?

    @current_user = User.find_by_email!(payload['email'])
  rescue JWT::DecodeError => e
    Rails.logger.error e.message
    Rails.logger.error e.backtrace.join("\n")

    raise e.message
  end

  def certificates
    cached = Rails.cache.read(CERTS_CACHE_KEY)
    return cached if cached.present?
  
    res = Net::HTTP.get_response(URI(CERTS_URI))
    raise 'Fetch certificates error' unless res.is_a?(Net::HTTPSuccess)
  
    body = JSON.parse(res.body)
    expires_at = Time.zone.parse(res.header['expires'])
    Rails.cache.write(CERTS_CACHE_KEY, body, expires_in: expires_at - Time.current)
  
    body
  end
end
