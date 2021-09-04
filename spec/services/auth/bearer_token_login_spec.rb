# frozen_string_literal: true

RSpec.describe Auth::BearerTokenLogin do
  describe '#call' do
    subject { described_class.call(token) }

    let(:user) { create(:user) }
    let(:token) { Auth::BearerTokenGenerator.call(user.id) }

    context 'when token is valid' do
      it { is_expected.to eq(user) }
    end

    context 'when token has wrong secret' do
      before do
        token
        allow(Auth::Config).to receive(:jwt_secret).and_return('wrong_secret')
      end

      it { is_expected.to be_nil }
    end

    context 'when token is expired' do
      before { allow(Auth::Config).to receive(:expires_at).and_return(1.minute.ago.to_i) }

      it { is_expected.to be_nil }
    end

    context 'when jti doesnt exists in database' do
      let(:parsed_token) { JWT.decode(token, ENV['JWT_SECRET']) }

      before { Auth::Database.revoke(parsed_token.first['jti']) }

      it { is_expected.to be_nil }
    end
  end
end
