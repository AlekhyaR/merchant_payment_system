# frozen_string_literal: true

require 'rails_helper'

describe Admins::Merchants::Update do
  subject(:operation) { described_class.call(user: admin, params: params) }

  let(:params) do
    {
      id: merchant.id,
      email: email,
      name: 'Merchant Name',
      description: 'Description'
    }
  end
  let(:admin) { create :user }
  let(:email) { 'merchant@test.com' }
  let(:merchant) { create :user }

  it_behaves_like 'an operation'
  it_behaves_like 'an operation allowed for admin'

  it { expect(described_class.contract_klass).to eq(User) }

  context 'when contract is not valid' do
    let(:email) { nil }

    it { expect { operation }.to raise_error(ActiveRecord::RecordInvalid) }
  end

  context 'when merchant does not exist' do
    let(:params) { { id: -1 } }

    it { expect { operation }.to raise_error(ActiveRecord::RecordNotFound) }
  end

  context 'when unknown param' do
    let(:params) { { id: merchant.id, unknown: 'unknown' } }

    it { is_expected.to be_failed }
  end
end
