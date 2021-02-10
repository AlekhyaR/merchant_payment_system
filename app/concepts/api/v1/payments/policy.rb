# frozen_string_literal: true

module Api
  module V1
    module Payments
      class Policy < ApplicationPolicy
        def initialize(user, payment)
          super
          @merchant = user
          @payment = payment
        end

        def create?
            merchant_active? &&
            payment_merchant_match?
        end

        private

        def merchant_active?
          @merchant.active?
        end

        def payment_merchant_match?
          @merchant == @payment.user
        end
      end
    end
  end
end
