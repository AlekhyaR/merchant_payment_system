class AuthenticationTokenService
  HMAC_SECRET = 'mySecretK3y'
  ALGORITHM_TYPE = 'HS256'

  def self.call(merchant_user_id)
    payload = { merchant_user_id: merchant_user_id }
    
    JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
  end
end