# frozen_string_literal: true

RSpec.describe Apilayer::Exchanges do
  describe '#convert', :vcr do
    subject { described_class.convert(amount, from, to) }

    let(:amount) { 10 }
    let(:from) { 'BRL' }
    let(:to) { 'USD' }

    context 'when data is valid' do
      it 'returns converted data' do
        expect(subject['success']).to eq(true)
        expect(subject['result']).to eq(2.02482)
      end
    end
  end
end
