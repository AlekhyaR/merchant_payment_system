require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user1 = create(:user)
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }

    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_uniqueness_of(:email) }

    it do
        should define_enum_for(:role).
          with_values([:merchant, :admin])
      end

    it do
      should define_enum_for(:status).
        with_values([:active, :inactive])
    end
  end
end
