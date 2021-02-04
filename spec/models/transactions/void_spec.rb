# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transactions::Void, type: :model do
  describe 'factory' do
    subject(:void) { create(:void, status: :voided) }

    it { is_expected.to be_valid }

    it 'and parent auth belong to the same merchant' do
      expect(void.user).to eq(void.authorize.user)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:customer_email) }
    it { is_expected.to validate_presence_of(:uuid) }
    it { is_expected.to belong_to(:authorize).required(true) }
    it { is_expected.to belong_to(:user).required(true) }

    context 'when uuid is not unique' do
      before { create :void, status: :error }

      it { is_expected.to validate_uniqueness_of(:uuid) }
    end
  end

  describe 'relations' do
    it { is_expected.to belong_to(:authorize).class_name('Transactions::Authorize') }
    it { is_expected.to belong_to(:user).class_name('User') }
  end
end
