# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::Payments::Authorize::Contract do
  subject(:contract) { described_class.new(params) }

  let(:params) do
    {
      amount: 100,
      user: merchant,
      uuid: uuid,
      customer_email: customer_email,
      customer_phone: customer_phone,
      notification_url: notification_url
    }
  end

  let(:merchant) { create :user }
  let(:uuid) { 'test' }
  let(:customer_email) { 'customer@test.com' }
  let(:customer_phone) { '0123456789' }
  let(:notification_url) { 'http://mysite/my_notification_endpoint' }

  it { is_expected.to be_valid }

  describe 'to_transaction' do
    subject(:transaction) { contract.to_transaction }

    it { is_expected.to be_kind_of(Transactions::Authorize) }
    it { expect(transaction.amount).to eq(100) }
    it { expect(transaction.user).to eq(merchant) }
    it { expect(transaction.uuid).to eq(uuid) }
    it { expect(transaction.customer_email).to eq(customer_email) }
    it { expect(transaction.customer_phone).to eq(customer_phone) }
  end
end
