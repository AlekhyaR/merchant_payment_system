# frozen_string_literal: true

module Transactions
  class CaptureProcess
    included Service
    DoubleCaptureError = Class.new(Service::Error)
    AuthorizeStateError = Class.new(Service::Error)

    def initialize(transaction:)
      @transaction = transaction
      @merchant = transaction.user
    end

    def call
      return if @transaction.persisted?

      @transaction.authorize.with_lock do
        ensure_authorize
        process_transaction
      end
    rescue Service::Error => e
      raise e
    rescue StandardError => e
      raise Service::Error, e
    end

    private

    def ensure_authorize
      ensure_authorize_approved
      ensure_single_capture
    end

    def ensure_single_capture
      return unless Transactions::Capture.approved.exists?(authorize: @transaction.authorize)

      raise DoubleCaptureError
    end

    def ensure_authorize_approved
      return if @transaction.authorize.approved?

      raise AuthorizeStateError
    end

    def process_transaction
      approve_transaction
    end

    def approve_transaction
      @transaction.approved!
    end
  end
end
