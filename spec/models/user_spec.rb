# frozen_string_literal: true

RSpec.describe User, type: :model do
  describe 'validations' do
    before { create(:user) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to allow_value('test@example.com').for(:email) }
    it { is_expected.not_to allow_value('test.example.com').for(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end
end
