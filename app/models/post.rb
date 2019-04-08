# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id               :bigint(8)        not null, primary key
#  title            :string(255)
#  body             :text(65535)
#  description      :text(65535)
#  slug             :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  banner_image_url :string(255)
#  author_id        :integer
#  published        :boolean          default(FALSE)
#  published_at     :datetime
#

class Post < ApplicationRecord
  acts_as_taggable # Alias for acts_as_taggable_on :tags

  # association
  belongs_to :author

  # scopes
  scope :published, -> { where(published: true) }
  scope :list_for_top, lambda { |page, tag|
    paginated_post(page).with_tag(tag)
  }
  scope :list_for_blog, lambda { |page, tag|
    recent_paginated_post(page).with_tag(tag)
  }
  scope :paginated_post, ->(page) { most_recent.paginate(page: page, per_page: 6) }
  scope :recent_paginated_post, ->(page) { most_recent.paginate(page: page, per_page: 24) }
  scope :most_recent, -> { order(created_at: :desc) }
  scope :with_tag, ->(tag) { tagged_with(tag) if tag.present? }

  # Friendly ID gem
  extend FriendlyId
  friendly_id :title, use: :slugged

  def should_generate_new_friendly_id?
    title_changed?
  end

  # publish / unpublish
  def display_day_published
    if published_at.present?
      "Published #{published_at.strftime('%-b %-d, %Y')}"
    else
      'Not published yet.'
    end
  end

  def publish
    update(published: true, published_at: Time.zone.now)
  end

  def unpublish
    update(published: false, published_at: nil)
  end
end
