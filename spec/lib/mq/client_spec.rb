# frozen_string_literal: true

RSpec.describe Mq::Client do
  describe '.connection' do
    subject { described_class.connection }

    it { is_expected.to be_instance_of(Bunny::Session) }
  end

  describe '.channel' do
    subject { described_class.channel }

    it { is_expected.to be_instance_of(Bunny::Channel) }
  end
end
