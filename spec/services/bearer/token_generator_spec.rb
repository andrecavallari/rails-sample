# frozen_string_literal: true

RSpec.describe Bearer::TokenGenerator do
  describe '.call' do
    subject(:token) { described_class.call(1) }

    let(:parsed_token) { OpenStruct.new JWT.decode(token, ENV['JWT_SECRET']).first }

    before { travel_to(DateTime.new(2021, 9, 4, 10)) }

    after { travel_back }

    it 'returns a token', :aggregate_failures do
      expect(token).to be_a(String)
      expect(token).not_to be_empty
      expect(parsed_token).to have_attributes(
        iat: 1_630_749_600,
        exp: anything,
        iss: Bearer::Config::ISSUER,
        jti: anything
      )
    end
  end
end
