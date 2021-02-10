# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::Payments::Policy do
  subject { described_class.new(merchant, request).create? }

  let(:request) { double(user: merchant, capture_transaction: capture) }
  let(:merchant) { create :user }
  let(:capture) { create :capture, user: merchant, status: 'captured' }

  it { is_expected.to be_truthy }

  context 'when merchant is inactive' do
    let(:merchant) { create :user, status: :inactive }

    it { is_expected.to be_falsey }
  end

  context 'when request is from other merchant' do
    let(:request) { double(user: create(:user), capture_transaction: capture) }

    it { is_expected.to be_falsey }
  end
end
