# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id           :bigint(8)        not null, primary key
#  title        :string
#  body         :text
#  slug         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  author_id    :integer
#  published    :boolean          default(FALSE)
#  published_at :datetime
#

FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "this is the #{n}th post!" }
    sequence(:body) { |n| "this is my #{n}th post on this blog." }
    # association :author, factory: :author
  end
end
