# frozen_string_literal: true

module Transactions
  class RefundProcess
    include Service
    InsufficientFundsError = Class.new(Error)

    def initialize(transaction:)
      @transaction = transaction
      @merchant = transaction.user
    end

    def call
      return if @transaction.persisted?

      @transaction.capture.with_lock do
        ensure_funds_available
        approve_transaction
        update_capture
      end
    rescue Error => e
      raise e
    rescue StandardError => e
      raise Error, e
    end

    private

    def ensure_funds_available
      return if @transaction.capture.remaining_amount >= @transaction.amount

      raise InsufficientFundsError
    end

    def approve_transaction
      @transaction.approved!
    end

    def update_capture
      @transaction.capture.refunded!
    end
  end
end
