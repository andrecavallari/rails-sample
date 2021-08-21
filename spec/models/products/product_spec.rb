# frozen_string_literal: true

RSpec.describe Products::Product, type: :model do
  describe 'validations' do
    before { create(:products_product) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:segment) }
  end

  describe '#set_final_price' do
    subject(:product) { create(:products_product, price: 100.0, segment: segment) }

    context 'when adding 10%' do
      let(:segment) { create(:products_segment, operation: 'price + (price * 0.1)') }

      it { expect(product.final_price).to eq(110.0) }
    end

    context 'when removing 10%' do
      let(:segment) { create(:products_segment, operation: 'price - (price * 0.1)') }

      it { expect(product.final_price).to eq(90.0) }
    end

    context 'when add 50' do
      let(:segment) { create(:products_segment, operation: 'price + 50') }

      it { expect(product.final_price).to eq(150.0) }
    end

    context 'when remove 50' do
      let(:segment) { create(:products_segment, operation: 'price - 50') }

      it { expect(product.final_price).to eq(50.0) }
    end
  end
end