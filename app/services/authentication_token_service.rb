class AuthenticationTokenService
  HMAC_SECRET = 'mySecretK3y'
  ALGORITHM_TYPE = 'HS256'

  def self.generate_token(merchant_user_id)
    payload = { merchant_user_id: merchant_user_id }
    
    JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
  end

  def self.decoded_token(token)
    @decoded = JWT.decode(token, HMAC_SECRET, {"alg": ALGORITHM_TYPE})
  end
end