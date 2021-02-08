class AuthenticationTokenService
  HMAC_SECRET = 'mySecretK3y'
  ALGORITHM_TYPE = '""HS256""'
  class << self
  # def process_token
  #   if request.headers['Authorization'].present?
  #     begin
  #       jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1].remove('"'), Rails.application.secrets.secret_key_base).first
  #       @current_user_id = jwt_payload['id']
  #     rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
  #       head :unauthorized
  #     end
  #   end
  # end
    def generate_token(merchant_user_id)
      payload = { merchant_user_id: merchant_user_id }
      JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
    end

    def decode_token(token)
      begin
        decoded = JWT.decode(token, HMAC_SECRET, true, algorith: ALGORITHM_TYPE)
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        return false
      end
      return decoded[0]
    end
  end
end