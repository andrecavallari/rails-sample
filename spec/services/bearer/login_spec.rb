# frozen_string_literal: true

RSpec.describe Bearer::Login do
  describe '#call' do
    subject { described_class.call(token) }

    let(:user) { create(:user) }
    let(:token) { Bearer::TokenGenerator.call(user.id) }

    context 'when token is valid' do
      it { is_expected.to eq(user) }
    end

    context 'when token has wrong secret' do
      before do
        token
        stub_const('Bearer::Config::SECRET', 'wrong_secret')
      end

      it { is_expected.to be_nil }
    end

    context 'when token is expired' do
      before { allow(Bearer::Config).to receive(:expires_at).and_return(1.minute.ago.to_i) }

      it { is_expected.to be_nil }
    end

    context 'when jti doesnt exists in database' do
      let(:parsed_token) { JWT.decode(token, ENV['JWT_SECRET']) }

      before { Bearer::Database.revoke(parsed_token.first['jti']) }

      it { is_expected.to be_nil }
    end

    context 'when token is invalid' do
      let(:token) { 'invalid_token' }

      it { is_expected.to be_nil }
    end
  end
end
