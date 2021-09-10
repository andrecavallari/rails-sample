# frozen_string_literal: true

RSpec.describe Bearer::Database do
  describe '.jti' do
    subject { described_class.jti(1) }

    it { is_expected.to match /\A[a-zA-Z0-9]{6}\z/ }
  end

  describe '.user_id' do
    subject { described_class.user_id(jti) }

    let!(:jti) { described_class.jti(1) }

    it { is_expected.to eq('1') }
  end

  describe '.revoke' do
    subject(:action) { described_class.revoke(jti) }

    let!(:jti) { described_class.jti(1) }

    it 'revokes the jti', :aggregate_failures do
      expect(action).to eq(1)
      expect(described_class.user_id(1)).to be_nil
    end
  end
end
