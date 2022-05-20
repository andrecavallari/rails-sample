# frozen_string_literal: true

RSpec.describe Apilayer::Exchanges do
  describe '#convert', :vcr do
    subject(:action) { described_class.convert(amount, from, to) }

    let(:amount) { 10 }
    let(:from) { 'BRL' }
    let(:to) { 'USD' }

    context 'when data is valid', :aggregate_failures do
      it 'returns converted data' do
        expect(action['success']).to be(true)
        expect(action['result']).to eq(2.02482)
      end
    end
  end
end
