# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::Payments::Presenter do
  subject(:presenter) { described_class.new(void) }

  let(:void) { create :void, status: 'voided' }

  it { expect(presenter.uuid).to eq(void.uuid) }
  it { expect(presenter.status).to eq(void.status) }
  it { expect(presenter.processed_at).to eq(void.created_at) }
end
