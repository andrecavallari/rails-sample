# frozen_string_literal: true

RSpec.describe Auth::PasswordService do
  subject { described_class.new(email, password).call }

  describe '#call' do
    let(:email) { 'user@example.com' }
    let(:password) { 'foobar123' }
    let!(:user) { create(:user, email: 'user@example.com', password: 'foobar123') }

    context 'when email and password are valid' do
      it { is_expected.to eq(user) }
    end

    context 'when email is invalid' do
      let(:email) { 'lorem@ipsum.com' }

      it { is_expected.to be_nil }
    end

    context 'when password is invalid' do
      let(:password) { 'SomeInvalidPassword' }

      it { is_expected.to be_nil }
    end
  end
end
