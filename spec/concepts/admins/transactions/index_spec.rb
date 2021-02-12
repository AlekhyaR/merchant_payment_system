# frozen_string_literal: true

require 'rails_helper'

describe Admins::Transactions::Index do
  subject(:operation) { described_class.call(user: admin, params: params, presenter: presenter) }

  let(:user) { create :user }
  let(:admin_user) { user.admin! }
  let(:admin) { user }
  let(:params) { {} }
  let(:presenter) { double(new: true) }
  let!(:authorize) { create :authorize }
  let!(:capture) { create :capture, status: 'approved' }

  it_behaves_like 'an operation'
  it_behaves_like 'an operation allowed for admin'
  it do
    operation
    expect(presenter).to have_received(:new).with(match_array([authorize, capture, capture.authorize]))
  end

  context 'when filtered by merchant_id' do
    let(:params) { { merchant_id: capture.merchant_id } }

    it do
      operation
      expect(presenter).to have_received(:new).with(match_array([capture, capture.authorize]))
    end
  end
end
