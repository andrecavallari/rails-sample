# frozen_string_literal: true

FactoryBot.define do
  factory :store_product, class: 'Store::Product' do
    segment { create(:store_segment) }
    sequence(:name) { |n| "Product #{n}" }
    price { 100.0 }
  end
end
