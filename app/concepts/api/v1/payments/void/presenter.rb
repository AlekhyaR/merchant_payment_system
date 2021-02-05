# frozen_string_literal: true

module Api
  module V1
    module Payments
      module Void
        class Presenter < Payments::Presenter
          def authorize
            @transaction.authorize.uuid
          end

          def to_partial_path
            'payments/void'
          end
        end
      end
    end
  end
end
