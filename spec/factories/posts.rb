# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "this is the #{n}th post!" }
    sequence(:body) { |n| "this is my #{n}th post on this blog." }
    # association :author, factory: :author
  end
end
