# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title 'nice to meet you!'
    body 'this is my first post on this blog.'
    association :author, factory: :author, id: 1
  end
end
