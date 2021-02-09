# frozen_string_literal: true

require 'rails_helper'

describe Admins::Merchants::Index do
  subject(:operation) { described_class.call(user: admin, params: params) }

  let(:params) do
    {
      email: 'test@test.com',
      name: 'Merchant Name',
      description: 'Description',
      password: 'Merchant_user124'
    }
  end

  let!(:merchant1) { create :user }
  let!(:merchant2) { create :user }

  let(:admin) { create :user }

  it_behaves_like 'an operation'
  it_behaves_like 'an operation allowed for admin'
end
