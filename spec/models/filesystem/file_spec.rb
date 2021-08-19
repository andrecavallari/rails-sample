# frozen_string_literal: true

RSpec.describe Filesystem::File, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:directory).class_name('Filesystem::Directory').optional }
  end

  describe '.content' do
    let!(:file) { create(:filesystem_file) }

    it 'has attachment', :aggregate_failures do
      expect(file.content).to be_a(ActiveStorage::Attached::One)
      expect(file.content.blob).to be_a(ActiveStorage::Blob)
      expect(file.content.filename).to eq('Document.pdf')
    end
  end
end
