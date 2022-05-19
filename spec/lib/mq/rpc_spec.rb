# frozen_string_literal: true

RSpec.describe Mq::Rpc do
  describe '.call' do
    subject { described_class.new(queue_name, 3).call(payload) }

    let(:queue_name) { 'rpc.test' }
    let(:payload) { [10, 2].to_json }

    before do
      queue = Mq::Client.channel.queue('rpc.test', exclusive: true)
      queue.subscribe do |info, properties, body|
        parsed_body = JSON.parse(body)
        response = parsed_body[0] * parsed_body[1]

        Mq::Client.channel.default_exchange.publish(
          response.to_s,
          routing_key: properties[:reply_to]
        )
      end
    end

    it 'returns response' do
      is_expected.to eq('20')
    end
  end
end
