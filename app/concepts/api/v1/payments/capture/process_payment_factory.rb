# frozen_string_literal: true

module Api
  module V1
    module Payments
      module Capture
        class ProcessPaymentFactory
          class << self
            def create(merchant:, params:)
              ProcessPayment.new(
                user: merchant,
                params: params,
                policy: Capture::Policy,
                service: Transactions::CaptureProcess,
                contract: Capture::Contract,
                presenter: Capture::Presenter
              )
            end
          end
        end
      end
    end
  end
end
