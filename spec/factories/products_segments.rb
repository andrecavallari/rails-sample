# frozen_string_literal: true

FactoryBot.define do
  factory :products_segment, class: 'Products::Segment' do
    sequence(:name) { |n| "Segment #{n}" }
    operation { 'price + (price * 0.1)' }
  end
end
