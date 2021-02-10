# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::Payments::Void::Presenter do
  subject(:presenter) { described_class.new(void) }

  let(:void) { create :void, status: 'voided'}

  it { expect(presenter.authorize).to eq(void.authorize.uuid) }
  it { expect(presenter.to_partial_path).to eq('payments/void') }
end
