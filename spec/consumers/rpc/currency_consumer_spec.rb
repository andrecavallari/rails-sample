# frozen_string_literal: true

RSpec.describe Rpc::CurrencyConsumer, type: :consumer do
  describe '.start' do
    subject { described_class.start }

    it { is_expected.to be_an_instance_of(Bunny::Consumer) }
  end

  describe '#call' do
    subject { described_class.new(info, properties, body).call }

    let(:info) do
      { consumer_tag: 'bunny-12345-678' }
    end

    let(:properties) do
      { reply_to: 'some-incoming-queue' }
    end

    let(:body) do
      { amount: 10, from: 'USD', to: 'BRL' }.to_json
    end

    it 'reply with apilayer response', :vcr do
      expect_any_instance_of(described_class).to receive(:reply).with('49.31502')

      subject
    end
  end
end
