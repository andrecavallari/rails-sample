# frozen_string_literal: true

RSpec.describe TweetWeatherConsumer, type: :consumer do
  describe '.start' do
    subject { described_class.start }

    it { is_expected.to be_an_instance_of(Bunny::Consumer) }
  end

  describe '#call' do
    subject(:action) { described_class.new(info, properties, body).call }

    let(:info) do
      OpenStruct.new(consumer_tag: 'bunny-12345-678', delivery_tag: 1)
    end

    let(:properties) do
      { headers: {} }
    end

    let(:body) do
      { city: 'Cascavel', state: 'Paraná' }.to_json
    end

    it 'tweets the weather', :vcr do
      expect(TweetWeatherJob).to receive(:perform_now)
        .with('Cascavel', 'Paraná').and_return('')
      expect_any_instance_of(TweetWeatherConsumer).to receive(:ack)

      action
    end
  end
end
