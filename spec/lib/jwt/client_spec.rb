# frozen_string_literal: true

RSpec.describe JWT::Client do
  let(:token) { 'eyJhbGciOiJIUzI1NiJ9.eyJmb28iOiJiYXIifQ.YQb8ifLo99itNsXaroV7ZGLBW08AGVcsErpndWSs-z8' }

  describe '.encode' do
    subject(:encode) { described_class.encode(foo: 'bar') }

    it { is_expected.to eq(token) }
  end

  describe '.decode' do
    subject(:decode) { described_class.decode(token) }

    it { is_expected.to eq('foo' => 'bar') }
  end
end
