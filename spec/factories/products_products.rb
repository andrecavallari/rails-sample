# frozen_string_literal: true

FactoryBot.define do
  factory :products_product, class: 'Products::Product' do
    segment { create(:products_segment) }
    sequence(:name) { |n| "Product #{n}" }
    price { 100.0 }
  end
end
