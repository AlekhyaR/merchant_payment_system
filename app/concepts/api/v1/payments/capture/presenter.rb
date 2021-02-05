# frozen_string_literal: true

module Api
  module V1
    module Payments
      module Capture
        class Presenter < Payments::Presenter
          delegate :amount,
                   to: :@transaction

          def authorize
            @transaction.authorize.uuid
          end

          def to_partial_path
            'payments/capture'
          end
        end
      end
    end
  end
end
