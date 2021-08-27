# frozen_string_literal: true

RSpec.describe Auth::GenerateTokenService do
  describe '#call' do
    subject(:token) { described_class.new(user, token_properties).call }

    let!(:user) { create(:user) }
    let(:token_properties) { { user_id: user.id, user_agent: 'Mozilla/5.0' } }

    it { expect { JWT::Client.decode(token) }.not_to raise_error }
  end
end
