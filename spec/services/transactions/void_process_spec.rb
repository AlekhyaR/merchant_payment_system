# frozen_string_literal: true

require 'rails_helper'

describe Transactions::VoidProcess do
  subject(:service) { described_class.new(transaction: void).call }

  let(:merchant) { create :user }
  let(:authorize) { create :authorize, user: merchant }
  let(:void) do
    build(:void, :pending, authorize: authorize, user: merchant)
  end

  before { create(:void, authorize: authorize, status: :error) }

  # it { expect { service }.to change(void, :approved?).to(true) }
  # it { expect { service }.to change(void, :persisted?).to(true) }
  # it { expect { service }.to change(authorize, :reversed?).to(true) }

  context 'when transaction processing fails for some reason' do
    let(:authorize) { create :authorize, user: merchant }
    let(:void) { build(:void, :pending, authorize: authorize, customer_email: nil) }

    it { expect { service }.to raise_error(Service::Error) }
  end

  context 'when transaction is processed already' do
    let(:void) { create :void, status: :approved }

    it { expect { service }.not_to change { void.reload.updated_at } }
  end

  context 'when authorize transaction already voided' do
    let(:authorize) { create :authorize, status: :voided, user: merchant }

    it { expect { service }.to raise_error(described_class::AuthorizeUnvoidableError) }
  end

  context 'when authorize transaction has captured' do
    let(:capture) { create :capture, user: merchant, status: :captured }
    let(:authorize) { capture.authorize }

    it { expect { service }.to raise_error(described_class::AuthorizeUnvoidableError) }
  end

  context 'when authorize transaction has error' do
    let(:authorize) { create :authorize, status: :declined, user: merchant }

    it { expect { service }.to raise_error(described_class::AuthorizeUnvoidableError) }
  end
end
