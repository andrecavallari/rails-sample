# frozen_string_literal: true

RSpec.describe JWT::Client do
  let(:token) { 'eyJhbGciOiJIUzI1NiJ9.eyJmb28iOiJiYXIifQ.oB-hPP-iM8gpHyhhTnltlh9Ph8WdapCcPRZ2zJ_AwBs' }

  before { stub_const('ENV', 'JWT_SECRET' => 'secret') }

  describe '.encode' do
    subject(:encode) { described_class.encode(foo: 'bar') }

    it { is_expected.to eq(token) }
  end

  describe '.decode' do
    subject(:decode) { described_class.decode(token) }

    it { is_expected.to eq('foo' => 'bar') }
  end
end
