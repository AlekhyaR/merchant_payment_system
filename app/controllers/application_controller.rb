class ApplicationController < ActionController::Base
  respond_to :html, :json
  protect_from_forgery with: :null_session
  before_action :process_token

  include ApplicationHelper
  
  # Check for auth headers - if present, decode or send unauthorized response (called always to allow current_user)
  def process_token
    binding.pry
    decoded = AuthenticationTokenService.decode_token(params["authenticity_token"])
  end
end
