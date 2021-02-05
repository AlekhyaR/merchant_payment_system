# frozen_string_literal: true

require 'rails_helper'

describe Transactions::CaptureProcess do
  subject(:service) { described_class.new(transaction: capture).call }

  let(:merchant) { create :user }
  let(:authorize) { create :authorize, user: merchant }
  let(:capture) do
    build(:capture, status: :pending, authorize: authorize, user: merchant, amount: 300)
  end

  before { create(:capture, authorize: authorize, status: :error) }

  context 'when transaction processing fails for some reason' do
    let(:capture) { build(:capture, :pending, amount: 0) }

    it { expect { service }.to raise_error(Service::Error) }
  end

  context 'when transaction is processed already' do
    let(:capture) { create(:capture, status: :approved) }

    it { expect { service }.not_to change { capture.reload.updated_at } }
  end

  context 'when authorize transaction has captured' do
    before { create(:capture, authorize: authorize, status: :approved) }

    it { expect { service }.to raise_error(described_class::AuthorizeStateError) }
  end

  context 'when authorize is approved' do
    let(:authorize) { create :authorize, status: :pending }

    it { expect { service }.to raise_error(described_class::AuthorizeStateError) }
  end
end
