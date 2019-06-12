# frozen_string_literal: true

FactoryBot.define do
  factory :author do
    name { 'testuser' }
    email { 'test@test.abc' }
    password { 'password' }
  end
end
