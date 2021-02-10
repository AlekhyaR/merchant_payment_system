# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::Payments::Refund::Policy do
  subject { described_class.new(merchant, request).create? }

  let(:merchant) { create :user }
  let(:capture) { create :capture, user: merchant, status: 'approved' }
  let(:request) do
    instance_double(
      'Api::V1::Payments::Refund::Contract',
      user: merchant,
      capture_transaction: capture
    )
  end

  it { is_expected.to be_truthy }

  context 'when merchant is inactive' do
    let(:merchant) { create :user, status: :inactive }

    it { is_expected.to be_falsey }
  end

  context 'when capture is from other merchant' do
    let(:capture) { create :capture, status: 'captured' }

    it { is_expected.to be_falsey }
  end

end
