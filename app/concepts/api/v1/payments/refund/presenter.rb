# frozen_string_literal: true

module Api
  module V1
    module Payments
      module Refund
        class Presenter < Payments::Presenter
          delegate :amount,
                   to: :@transaction

          def capture
            @transaction.capture.uuid
          end

          def to_partial_path
            'payments/refund'
          end
        end
      end
    end
  end
end
