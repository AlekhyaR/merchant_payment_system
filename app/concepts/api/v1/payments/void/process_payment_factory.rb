# frozen_string_literal: true

module Api
  module V1
    module Payments
      module Void
        class ProcessPaymentFactory
          class << self
            def create(merchant:, params:)
              ProcessPayment.new(
                user: merchant,
                params: params,
                policy: Void::Policy,
                service: Transactions::VoidProcess,
                contract: Void::Contract,
                presenter: Void::Presenter
              )
            end
          end
        end
      end
    end
  end
end
