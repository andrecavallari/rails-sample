# frozen_string_literal: true

RSpec.describe Auth::BearerTokenService do
  describe '#call' do
    subject { described_class.new(token).call }

    context 'with valid token' do
      let(:user) { create(:user) }
      let(:token) { Auth::GenerateTokenService.new(user, user_agent: 'Mozilla/5.0').call }

      it { is_expected.to eq(user) }
    end

    context 'with invalid token' do
      let(:token) { 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.9J6Dln8UQ_49SdYWVQ1xtwThY0RLEtnD9hwTOehoHnM' }

      it { is_expected.to eq(false) }
    end
  end
end
