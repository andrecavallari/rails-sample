# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    sequence(:email) { |n| "john-doe-#{n}@example.com" }
    password { 'foobar123' }
  end
end
