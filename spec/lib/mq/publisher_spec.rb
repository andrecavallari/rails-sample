# frozen_string_literal: true

RSpec.describe Mq::Publisher do
  describe '.tweet_weather' do
    subject(:action) do
      described_class.tweet_weather(
        payload[:city],
        payload[:state]
      )
    end

    let(:payload) do
      {
        city: 'Cascavel',
        state: 'Paraná'
      }
    end

    it do
      expect_any_instance_of(Bunny::Exchange)
        .to receive(:publish).with(payload.to_json)

      action
    end
  end
end
