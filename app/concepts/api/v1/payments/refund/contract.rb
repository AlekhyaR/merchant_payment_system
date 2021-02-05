# frozen_string_literal: true

module Api
  module V1
    module Payments
      module Refund
        class Contract < Payments::Contract
          include AmountAttribute

          attr_accessor :capture

          validates :capture, presence: true
          validate :validate_capture_state
          validate :validate_capture_amount

          def to_transaction
            Transactions::Refund.new(
              uuid: uuid,
              amount: amount,
              customer_email: customer_email,
              customer_phone: customer_phone,
              user: user,
              capture: capture_transaction
            )
          end

          def capture_transaction
            return @capture_transaction if defined?(@capture_transaction)

            @capture_transaction = Transactions::Capture.find_by(
              user: user,
              uuid: capture
            )
          end

          private

          def validate_capture_state
            return unless capture_transaction
            return if capture_transaction.approved? || capture_transaction.refunded?

            errors.add(:capture, :invalid_state)
          end

          def validate_capture_amount
            return unless capture_transaction
            return if capture_transaction.remaining_amount >= BigDecimal(amount)

            errors.add(:amount, :insufficient_funds)
          rescue ArgumentError
            errors.add(:amount, :not_a_number)
          end
        end
      end
    end
  end
end
