# frozen_string_literal: true

require 'rails_helper'

describe Transactions::RefundProcess do
  subject(:service) { described_class.new(transaction: refund).call }

  let(:merchant) { create :user }
  let(:capture) { create(:capture, status: :captured, user: merchant, amount: 300) }
  let(:refund) do
    build(:refund, :pending, user: merchant, capture: capture, amount: 100)
  end

  context 'when transaction processing fails for some reason' do
    let(:refund) { build(:refund, :pending, amount: 0) }

    it { expect { service }.to raise_error(Service::Error) }
  end

  context 'when transaction is processed already' do
    let(:refund) { create(:refund, status: :approved) }

    it { expect { service }.not_to change { refund.reload.updated_at } }
  end

  context 'when captured transaction has refund' do
    before { create(:refund, capture: capture, status: :captured, amount: 200) }

    context 'when capture is fully refunded' do
      before { create(:refund, capture: capture, status: :approved, amount: 300) }

      it { expect { service }.to raise_error(described_class::InsufficientFundsError) }
    end
  end
end
