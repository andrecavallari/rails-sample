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

  describe '#crypt_password' do
    let(:user) { build(:user, password: 'foobar123') }

    before { user.save! }

    it 'encrypts the password' do
      expect(user.password).to match(/^\$2[ayb]\$.+$/)
    end
  end
end
