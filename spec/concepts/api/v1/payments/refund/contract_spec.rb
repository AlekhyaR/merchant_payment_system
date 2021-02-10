# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::Payments::Refund::Contract do
  subject(:contract) { described_class.new(params) }

  let(:params) do
    {
      amount: amount,
      user: merchant,
      uuid: 'test',
      customer_email: 'customer@test.com',
      customer_phone: '0123456789',
      notification_url: 'http://mysite/my_notification_endpoint',
      capture: capture.uuid
    }
  end
  let(:amount) { 100 }
  let(:merchant) { create :user }
  let(:capture) { create(:capture, amount: 100, user: merchant, status: 'approved') }

  it { is_expected.to be_valid }

  describe 'to_transaction' do
    subject(:transaction) { contract.to_transaction }

    it { is_expected.to be_kind_of(Transactions::Refund) }
    it { expect(transaction.amount).to eq(100) }
    it { expect(transaction.user).to eq(merchant) }
    it { expect(transaction.uuid).to eq('test') }
    it { expect(transaction.customer_email).to eq('customer@test.com') }
    it { expect(transaction.customer_phone).to eq('0123456789') }
  end

  # context 'when amount is not a number' do
  #   let(:amount) { '100' }

  #   it { is_expected.to be_valid }

  #   context 'when amount is asdf' do
  #     let(:amount) { 'asdf' }

  #     it { is_expected.not_to be_valid }
  #   end
  # end

  # context 'when amount mismatch capture amount' do
  #   let(:amount) { 150 }

  #   it { is_expected.not_to be_valid }
  # end

  # context 'when capture transaction has refund' do
  #   let(:capture) { create(:capture, amount: 100, status: :refunded, merchant: merchant) }
  #   let(:amount) { 50 }

  #   before { create(:refund, capture: capture, status: :approved, amount: 50) }

  #   it { is_expected.to be_valid }

  #   context 'when capture is fully refunded' do
  #     before { create(:refund, capture: capture, status: :approved, amount: 100) }

  #     it { is_expected.not_to be_valid }
  #   end
  # end

  # context 'when capture with error' do
  #   let(:capture) { create(:capture, amount: 100, status: :error, merchant: merchant) }

  #   it { is_expected.not_to be_valid }
  # end
end
