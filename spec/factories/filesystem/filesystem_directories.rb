# frozen_string_literal: true

FactoryBot.define do
  factory :filesystem_directory, class: 'Filesystem::Directory' do
    sequence(:name) { |n| "Directory #{n}" }
    parent_id { nil }
  end
end
