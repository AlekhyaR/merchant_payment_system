require 'rails_helper'

describe Admins::Merchants::Create do
  subject(:operation) { described_class.call(user: admin, params: params) }

  let(:params) do
    {
      email: email,
      name: 'Merchant Name',
      description: 'Description',
      password: 'Merchant_user124'
    }
  end
  let(:admin) { create(:user, :admin) }
  let(:email) { 'merchant@test.com' }

  it { expect { operation }.to change(User, :count).by(2) }
  it { expect(described_class.contract_klass).to eq(User) }

  context 'when contract is not valid' do
    let(:email) { nil }

    it { is_expected.to be_failed }
  end
end
