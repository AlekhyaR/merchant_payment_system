# frozen_string_literal: true

module Transactions
  class Base < ApplicationRecord
    self.table_name = 'transactions'

    enum status: {
      pending: 'pending',
      approved: 'approved',
      declined: 'declined',
      captured: 'captured',
      voided: 'voided',
      refunded: 'refunded',
      error: 'error'
    }

    belongs_to :user, foreign_key: :merchant_id

    validates :uuid, presence: true, uniqueness: true
    validates :amount, numericality: { greater_than: 0 }, presence: true
    validates :customer_email, presence: true
    validates :notification_url, presence: true  
    validates :type, presence: true  

    def fail!
      self.uuid ||= SecureRandom.uuid
      self.status = :error
      save!(validate: false)
    end
  end
end
