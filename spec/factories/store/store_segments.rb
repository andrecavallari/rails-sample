# frozen_string_literal: true

FactoryBot.define do
  factory :store_segment, class: 'Store::Segment' do
    sequence(:name) { |n| "Segment #{n}" }
    operation { 'price + (price * 0.1)' }
  end
end
