# frozen_string_literal: true

module Transactions
  class Refund < Transactions::Base
    belongs_to :capture,
               class_name: 'Transactions::Capture',
               foreign_key: :parent_transaction_id,
               inverse_of: :refunds

    validates :amount,
              numericality: { greater_than: 0 },
              presence: true

    validates :status,
              inclusion: %w[captured refunded approved error],
              presence: true
  end
end
