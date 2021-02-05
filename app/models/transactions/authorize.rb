# frozen_string_literal: true

module Transactions
  class Authorize < Transactions::Base
    has_one :capture,
            class_name: 'Transactions::Capture',
            foreign_key: :parent_transaction_id,
            inverse_of: :authorize,
            dependent: :destroy

    has_one :void,
            class_name: 'Transactions::Void',
            foreign_key: :parent_transaction_id,
            inverse_of: :authorize,
            dependent: :destroy

    validates :amount,
              numericality: { greater_than: 0 },
              presence: true

    validates :status,
              inclusion: %w[pending approved declined voided],
              presence: true
  end
end
