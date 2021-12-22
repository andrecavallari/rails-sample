# frozen_string_literal: true

RSpec.describe StrUtils do
  describe '.find_repeated_letters' do
    subject { described_class.find_repeated_letters(word) }

    context 'when word has no repeated words' do
      let(:word) { 'presure' }

      it { is_expected.to eq('p') }
    end

    context 'when word has only one repeated word' do
      let(:word) { 'pressure' }

      it { is_expected.to eq('ss') }
    end

    context 'when word has more than one repeated word' do
      let(:word) { 'pressuure' }

      it { is_expected.to eq('ss') }
    end

    context 'when word has more than one repeated word and a bigger one' do
      let(:word) { 'pressuuure' }

      it { is_expected.to eq('uuu') }
    end

    context 'when is a phrase with two spaces' do
      let(:word) { 'a hot  dog' }

      it { is_expected.to eq('  ') }
    end
  end

  describe '.last_word_length' do
    subject { described_class.last_word_length(phrase) }

    context 'when have no spaces' do
      let(:phrase) { 'Hello World' }

      it { is_expected.to eq(5) }
    end

    context 'when have some spaces' do
      let(:phrase) { ' fly me  to   the moon   ' }

      it { is_expected.to eq(4) }
    end
  end
end
