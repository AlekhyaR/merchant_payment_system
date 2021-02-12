# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ActionController::API
      include Operation::ControllerHelpers
      include ApplicationHelper
      respond_to :json

      rescue_from Operation::NotAuthorizedError do
        render json: { errors: [I18n.t('controllers.api.v1.unauthorized')] }, status: :unauthorized
      end

      def auth_header
        header = request.headers['Authorization']
      end

      def decoded_token
        if auth_header
          token = auth_header.split(' ').last 
          begin
            @decoded = AuthenticationTokenService.decoded_token(token)
          rescue JWT::DecodeError
            nil
          end
        end
      end

      def logged_in_user
        if decoded_token
          merchant_id = @decoded[0]["merchant_user_id"]["merchant_user_id"]
          @current_user = User.find_by(id: merchant_id)
        end
      end

      def logged_in?
        !!logged_in_user
      end

      def authorized
        render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
      end
    end
  end
end
