# frozen_string_literal: true

module Api
  module V1
    module Payments
      module Void
        class Policy < Payments::Policy
          def create?
            super && authorize_merchant_march?
          end

          private

          def authorize_merchant_march?
            @payment.authorize_transaction&.user == @payment.user
          end
        end
      end
    end
  end
end
