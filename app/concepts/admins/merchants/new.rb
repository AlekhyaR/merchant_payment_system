# frozen_string_literal: true

module Admins
  module Merchants
    class New
      include Operation

      policy ApplicationPolicy
      contract ::User

      def call
        authorize! policy.admin?
      end
    end
  end
end
