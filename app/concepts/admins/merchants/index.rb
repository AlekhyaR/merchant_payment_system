# frozen_string_literal: true

module Admins
  module Merchants
    class Index
      include Operation

      policy ApplicationPolicy
      presenter ListPresenter
      contract ::User

      def call
        authorize! policy.admin?
        merchants = load_merchants
      ensure
        present(merchants)
      end

      private

      def load_merchants
        ::User.order(created_at: :desc).all
      end
    end
  end
end
