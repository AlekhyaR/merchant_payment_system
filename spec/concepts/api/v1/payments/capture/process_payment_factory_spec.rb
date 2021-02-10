# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::Payments::Capture::ProcessPaymentFactory do
  describe 'create' do
    subject(:operation) { described_class.create(merchant: double, params: {}) }

    it { is_expected.to be_kind_of(Api::V1::Payments::ProcessPayment) }
    it { expect(operation.policy_klass).to eq(Api::V1::Payments::Capture::Policy) }
    it { expect(operation.service_klass).to eq(Transactions::CaptureProcess) }
    it { expect(operation.contract_klass).to eq(Api::V1::Payments::Capture::Contract) }
    it { expect(operation.presenter_klass).to eq(Api::V1::Payments::Capture::Presenter) }
  end
end
