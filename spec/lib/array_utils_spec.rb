# frozen_string_literal: true

RSpec.describe ArrayUtils do
  describe '.symetric_difference' do
    subject { described_class.symetric_difference(a, b) }

    context 'when both have same values' do
      let(:a) { [1, 2, 3] }
      let(:b) { [1, 2, 3] }

      it { is_expected.to eq([]) }
    end

    context 'when values are all different' do
      let(:a) { [1, 2, 3] }
      let(:b) { [4, 5, 6] }

      it { is_expected.to eq([1, 2, 3, 4, 5, 6]) }
    end

    context 'when have some equal values' do
      let(:a) { [1, 2, 3] }
      let(:b) { [2, 3, 4] }

      it { is_expected.to eq([1, 4]) }
    end
  end
end
