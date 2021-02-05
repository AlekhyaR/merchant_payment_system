# frozen_string_literal: true

module Api
  module V1
    module Payments
      class Contract
        include ActiveModel::Model

        attr_accessor :customer_email,
                      :customer_phone,
                      :user,
                      :uuid

        validates :uuid, presence: true
        validates :customer_email, presence: true
        validates :user, presence: true
        validate :validate_uuid_uniqueness

        private

        def validate_uuid_uniqueness
          return unless user

          if Transactions::Base.exists?(merchant: user, uuid: uuid)
            errors.add(:uuid, :not_unique)
          elsif Transactions::Base.exists?(uuid: uuid)
            errors.add(:uuid, :invalid)
          end
        end
      end
    end
  end
end
