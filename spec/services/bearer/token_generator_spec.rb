# frozen_string_literal: true

RSpec.describe Bearer::TokenGenerator do
  describe '.call' do
    subject(:token) { described_class.call(1) }

    let(:parsed_token) { JWT.decode(token, ENV.fetch('JWT_SECRET', nil)).first }

    before { travel_to(DateTime.new(2021, 9, 4, 10)) }

    it 'returns a token', :aggregate_failures do
      expect(token).to be_a(String)
      expect(token).not_to be_empty
      expect(parsed_token['iat']).to eq(1_630_749_600)
      expect(parsed_token['exp']).to be_present
      expect(parsed_token['iss']).to eq(Bearer::Config::ISSUER)
      expect(parsed_token['jti']).to be_present
    end
  end
end
