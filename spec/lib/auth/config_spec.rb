# frozen_string_literal: true

RSpec.describe Auth::Config do
  describe '.expiration_time' do
    let(:expiration_time) { ENV.fetch('JWT_EXPIRATION_TIME', 21_600) }

    it { expect(described_class.expiration_time).to eq(expiration_time) }
  end

  describe '.expires_at' do
    let(:expires_at) { Time.now.to_i + described_class.expiration_time }

    it { expect(described_class.expires_at).to eq(expires_at) }
  end

  describe '.issuer' do
    let(:issuer) { ENV.fetch('JWT_ISSUER', 'https://andre.srv.br') }

    it { expect(described_class.issuer).to eq(issuer) }
  end

  describe '.jwt_secret' do
    it { expect(described_class.jwt_secret).to eq(ENV['JWT_SECRET']) }
  end
end
