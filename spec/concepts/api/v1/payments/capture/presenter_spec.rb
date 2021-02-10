# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::Payments::Capture::Presenter do
  subject(:presenter) { described_class.new(capture) }

  let(:capture) { create :capture, status: 'captured' }

  it { expect(presenter.amount).to eq(capture.amount) }
  it { expect(presenter.authorize).to eq(capture.authorize.uuid) }
  it { expect(presenter.to_partial_path).to eq('payments/capture') }
end
