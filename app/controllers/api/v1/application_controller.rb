# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ActionController::API
      include Operation::ControllerHelpers

      rescue_from Operation::NotAuthorizedError do
        render json: { errors: [I18n.t('controllers.api.v1.unauthorized')] }, status: :unauthorized
      end

      def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
          @decoded = JWT.decode(header)
          @current_user = User.find(@decoded[:user_id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { error: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
          render json: { error: e.message }, status: :unauthorized
        end
      end
    end
  end
end
