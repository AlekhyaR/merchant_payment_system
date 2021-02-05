# frozen_string_literal: true

require 'rails_helper'

describe Transactions::Cleanup do
  subject(:service) { described_class.call }

  let(:created_at) { 61.minutes.ago }

  before do
    create :authorize, created_at: created_at # +1
    create :capture, status: :captured, created_at: created_at    # +2
    create :refund, status: :refunded, created_at: created_at    # +3
    create :void, status: :voided, created_at: created_at  # +2
  end

  context 'when transactions created less than 1 hour ago' do
    let(:created_at) { 59.minutes.ago }

    it { expect { service }.not_to change { Transactions::Base.count } }
  end
end
