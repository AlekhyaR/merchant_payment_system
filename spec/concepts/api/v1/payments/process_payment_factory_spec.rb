# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::Payments::ProcessPaymentFactory do
  subject(:operation) { described_class.create(merchant: merchant, params: params) }

  let(:params) { { type: payment_type } }
  let(:merchant) { create :user }

  # context 'when authorize' do
  #   let(:payment_type) { 'authorize' }

  #   it { is_expected.to be_kind_of(Api::V1::Payments::ProcessPayment) }
  #   it { expect(operation.policy_klass).to eq(Api::V1::Payments::Policy) }
  #   it { expect(operation.contract_klass).to eq(Api::V1::Payments::Authorize::Contract) }
  #   it { expect(operation.presenter_klass).to eq(Api::V1::Payments::Authorize::Presenter) }
  #   it { expect(operation.service_klass).to eq(Transactions::AuthorizeProcess) }
  # end

  # context 'when Capture' do
  #   let(:payment_type) { 'capture' }

  #   it { is_expected.to be_kind_of(Api::V1::Payments::ProcessPayment) }
  #   it { expect(operation.policy_klass).to eq(Api::V1::Payments::Capture::Policy) }
  #   it { expect(operation.contract_klass).to eq(Api::V1::Payments::Capture::Contract) }
  #   it { expect(operation.presenter_klass).to eq(Api::V1::Payments::Capture::Presenter) }
  #   it { expect(operation.service_klass).to eq(Transactions::CaptureProcess) }
  # end

  context 'when refund' do
    let(:payment_type) { 'refund' }

    it { is_expected.to be_kind_of(Api::V1::Payments::ProcessPayment) }
    it { expect(operation.policy_klass).to eq(Api::V1::Payments::Refund::Policy) }
    it { expect(operation.contract_klass).to eq(Api::V1::Payments::Refund::Contract) }
    it { expect(operation.presenter_klass).to eq(Api::V1::Payments::Refund::Presenter) }
    it { expect(operation.service_klass).to eq(Transactions::RefundProcess) }
  end

  context 'when Void' do
    let(:payment_type) { 'void' }

    it { is_expected.to be_kind_of(Api::V1::Payments::ProcessPayment) }
    it { expect(operation.policy_klass).to eq(Api::V1::Payments::Void::Policy) }
    it { expect(operation.contract_klass).to eq(Api::V1::Payments::Void::Contract) }
    it { expect(operation.presenter_klass).to eq(Api::V1::Payments::Void::Presenter) }
    it { expect(operation.service_klass).to eq(Transactions::VoidProcess) }
  end

  context 'when unknown type' do
    let(:payment_type) { nil }

    it { expect { operation }.to raise_error(ArgumentError) }
  end
end
