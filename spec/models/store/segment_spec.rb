# frozen_string_literal: true

RSpec.describe Store::Segment, type: :model do
  describe 'validations' do
    before { create(:store_segment) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_presence_of(:operation) }
  end
end
