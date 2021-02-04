# frozen_string_literal: true

module Transactions
  class Void < Transactions::Base
    belongs_to :authorize,
               class_name: 'Transactions::Authorize',
               foreign_key: :parent_transaction_id,
               inverse_of: :void

    validates :status,
              inclusion: %w[voided approved error],
              presence: true
  end
end
