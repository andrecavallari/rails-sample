# frozen_string_literal: true

RSpec.describe TwitterClient, :vcr do
  describe '.tweet' do
    subject(:action) { described_class.tweet('Hi people!') }

    it 'tweets a message' do
      expect(action.id).to eq(1_427_015_457_391_919_105)
    end
  end
end
