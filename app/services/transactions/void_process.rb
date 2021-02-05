# frozen_string_literal: true

module Transactions
  class VoidProcess
    include Service
    AuthorizeUnvoidableError = Class.new(Error)

    def initialize(transaction:)
      @transaction = transaction
      @merchant = transaction.user
    end

    def call
      return if @transaction.persisted?

      @transaction.authorize.with_lock do
        ensure_authorize_voidable
        approve_transaction
        update_authorize
      end
    rescue Error => e
      raise e
    rescue StandardError => e
      raise Error, e
    end

    private

    def ensure_authorize_voidable
      un_voidable =
        @transaction.authorize.capture||
        @transaction.authorize.voided? ||
        @transaction.authorize.error?
      return unless un_voidable

      raise AuthorizeUnvoidableError
    end

    def approve_transaction
      @transaction.approved!
    end

    def update_authorize
      @transaction.authorize.voided!
    end
  end
end
