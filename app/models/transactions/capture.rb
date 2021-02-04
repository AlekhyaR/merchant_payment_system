# frozen_string_literal: true

module Transactions
  class Capture < Transactions::Base
    belongs_to :authorize,
               class_name: 'Transactions::Authorize',
               foreign_key: :parent_transaction_id,
               inverse_of: :capture

    has_many :refunds,
             class_name: 'Transactions::Refund',
             foreign_key: :parent_transaction_id,
             inverse_of: :capture,
             dependent: :destroy

    validates :amount,
              numericality: { greater_than: 0 },
              presence: true

    validates :status,
              inclusion: %w[approved captured error],
              presence: true

    # def remaining_amount
    #   amount - refunds.approved.sum(:amount)
    # end
  end
end
