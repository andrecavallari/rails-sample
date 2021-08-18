# frozen_string_literal: true

RSpec.describe Filesystem::Directory, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:parent).class_name('Filesystem::Directory').optional }
    it { is_expected.to have_many(:children).class_name('Filesystem::Directory') }
    it { is_expected.to have_many(:files).class_name('Filesystem::File') }
  end

  describe 'validations' do
    let!(:directory) { create(:filesystem_directory) }
    let(:new_directory) { build(:filesystem_directory, name:directory.name, parent_id:directory.parent_id) }

    it { is_expected.to validate_presence_of(:name) }

    it 'validates uniqueness', :aggregate_failures do
      expect(new_directory).not_to be_valid
      expect(new_directory.errors.full_messages).to include('Nome já está cadastrado neste mesmo nível')
    end
  end
end
