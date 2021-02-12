module Api 
  module V1 
    class AuthenticationController < ApplicationController
      class AuthenticationError < StandardError; end
      rescue_from ActionController::ParameterMissing, with: :parameter_missing
      rescue_from AuthenticationError, with: :handle_unauthenticated
      
      def create
        raise AuthenticationError unless merchant_user.authenticate(params.require(:password))
        token = AuthenticationTokenService.generate_token(merchant_user_id: merchant_user.id)
        render json: {token: token}, status: :created
      end
      
      private

      def merchant_user
        @merchant_user = User.find_by(email: params.require(:email))
      end

      def parameter_missing(e)
        render json: { error: e.message }, status: :unprocessable_entity
      end

      def handle_unauthenticated
        head :unauthorized
      end
    end
  end
end