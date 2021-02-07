class AuthenticationTokenService
  HMAC_SECRET = 'mySecretK3y'
  ALGORITHM_TYPE = 'HS256'
  def process_token
    if request.headers['Authorization'].present?
      begin
        jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1].remove('"'), Rails.application.secrets.secret_key_base).first
        @current_user_id = jwt_payload['id']
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        head :unauthorized
      end
    end
  end
  def self.call(merchant_user_id)
    payload = { merchant_user_id: merchant_user_id }
    @current_user_id = jwt_payload['id']
    JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
  end
end