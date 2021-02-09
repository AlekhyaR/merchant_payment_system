# frozen_string_literal: true

require 'rails_helper'

describe Admins::Merchants::New do
  subject(:operation) { described_class.call(user: admin, params: params) }

  let(:params) do
    {
      email: email,
      name: 'Merchant Name',
      description: 'Description',
      password: 'Merchant_user124'
    }
  end
  let(:admin) { create :user }
  let(:email) { 'merchant@test.com' }

  it_behaves_like 'an operation'
  it_behaves_like 'an operation allowed for admin'
end
