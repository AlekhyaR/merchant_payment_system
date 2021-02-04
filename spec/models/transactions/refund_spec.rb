# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transactions::Refund, type: :model do
  describe 'factory' do
    subject(:refund) { create(:refund, status: :refunded) }

    it { is_expected.to be_valid }

    it 'and parent charge belong to the same merchant' do
      expect(refund.user).to eq(refund.capture.user)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:customer_email) }
    it { is_expected.to validate_presence_of(:uuid) }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }
    it { is_expected.to belong_to(:capture).required(true) }
    it { is_expected.to belong_to(:user).required(true) }

    context 'when uuid is not unique' do
      before { create :refund, status: :error }

      it { is_expected.to validate_uniqueness_of(:uuid) }
    end
  end

  describe 'relations' do
    it { is_expected.to belong_to(:capture).class_name('Transactions::Capture') }
    it { is_expected.to belong_to(:user).class_name('User') }
  end
end
