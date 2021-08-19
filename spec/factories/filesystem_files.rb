# frozen_string_literal: true

FactoryBot.define do
  factory :filesystem_file, class: 'Filesystem::File' do
    content do
      path = Rails.root.join('spec/fixtures/files/Document.pdf')
      ActiveStorage::Blob.create_and_upload!(
        io: File.open(path),
        filename: 'Document.pdf',
        content_type: 'application/pdf'
      )
    end
  end
end
