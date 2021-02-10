# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::Payments::Contract, type: :model do
  subject(:contract) { described_class.new(params) }

  let(:params) do
    {
      user: merchant,
      uuid: uuid,
      customer_email: 'customer@test.com',
      customer_phone: '0123456789',
      notification_url: 'http://mysite/my_notification_endpoint'
    }
  end
  let(:uuid) { 'test' }
  let(:merchant) { create :user }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:uuid) }
  it { is_expected.to validate_presence_of(:customer_email) }
  it { is_expected.to validate_presence_of(:user) }

  context 'when uuid is not unique' do
    before { create :authorize, uuid: 'test', user: merchant, status: 'pending' }

    it do
      expect(contract).not_to be_valid
      expect(contract.errors).to be_added(:uuid, :not_unique)
    end

    context 'when from other merchant' do
      before { create :authorize, uuid: 'test-test' }

      let(:uuid) { 'test-test' }

      it 'does not expose details' do
        expect(contract).not_to be_valid
        expect(contract.errors).to be_added(:uuid, :invalid)
      end
    end
  end
end
