# frozen_string_literal: true

module Api
  module V1
    module Payments
      module Refund
        class Policy < Payments::Policy
          def create?
            super && capture_merchant_match?
          end

          private

          def capture_merchant_match?
            @payment.capture_transaction&.user == @payment.user
          end
        end
      end
    end
  end
end
