# frozen_string_literal: true

RSpec.describe JWT::DB do
  before { described_class.clear }

  after { described_class.clear }

  describe '.create' do
    subject(:action) { described_class.create(user_id, properties) }

    let(:user_id) { 1 }
    let(:properties) { { user_agent: 'Mozilla/5.0', time: Time.current } }

    it 'creates a new token' do
      expect(action).to match(/[a-zA-Z0-9]{10}/)
    end
  end

  describe '.exists?' do
    subject(:action) { described_class.exists?(1, uid) }

    context 'when exists' do
      let(:uid) { described_class.create(1, { user_agent: 'Mozilla/5.0' }) }

      it { expect(action).to eq(true) }
    end

    context 'when doesnt exists' do
      let(:uid) { '0000000000' }

      it { expect(action).to eq(false) }
    end
  end

  describe '.fetch' do
    let(:uid) { described_class.create(1, { user_agent: 'Mozilla/5.0' }) }

    it 'returns the properties' do
      expect(described_class.fetch(1, uid)).to eq(
        'user_agent' => 'Mozilla/5.0',
        'user_id' => '1'
      )
    end
  end

  describe '.destroy' do
    let(:uid) { described_class.create(1, { user_agent: 'Mozilla/5.0' }) }

    it 'destroy the key' do
      expect(described_class.destroy(1, uid)).to eq(1)
    end
  end

  describe '.reset_ttl' do
    let(:uid) { described_class.create(1, { user_agent: 'Mozilla/5.0' }) }

    it 'reset the ttl' do
      expect(described_class.reset_ttl(1, uid)).to eq(true)
    end
  end

  describe '.user_keys' do
    before do
      described_class.clear
      described_class.create(1, { user_agent: 'Mozilla/5.0' })
      described_class.create(1, { user_agent: 'Webkit/90.0' })
    end

    let(:keys) { described_class.user_keys(1) }

    it 'returns the keys', :aggregate_failures do
      expect(keys[0]).to match(/[a-zA-Z0-9]{10}/)
      expect(keys[1]).to match(/[a-zA-Z0-9]{10}/)
    end
  end

  describe '.clear' do
    before do
      described_class.clear
      10.times { described_class.create(1, { user_agent: 'Mozilla/5.0' }) }
    end

    it { expect(described_class.clear).to eq(10) }
  end
end
