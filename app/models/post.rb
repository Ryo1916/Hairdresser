# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id           :bigint(8)        not null, primary key
#  title        :string(255)
#  body         :text(65535)
#  slug         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  author_id    :integer
#  published    :boolean          default(FALSE)
#  published_at :datetime
#

class Post < ApplicationRecord
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_punchable

  # association
  belongs_to :author

  # validations
  validates_presence_of :title
  validates_presence_of :body

  # scopes
  scope :published, -> { where(published: true) }
  scope :descending_order, -> { order(created_at: :desc) }
  scope :recent_paginated_post, ->(page) { descending_order.paginate(page: page, per_page: 6) }
  scope :paginated_post, ->(page) { descending_order.paginate(page: page, per_page: 24) }
  scope :with_tag, ->(tag) { tagged_with(tag) if tag.present? }
  scope :list_for_top, lambda { |page, tag|
    recent_paginated_post(page).with_tag(tag)
  }
  scope :list_for_blog, lambda { |page, tag|
    paginated_post(page).with_tag(tag)
  }

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

  def next
    Post.published.where('published_at > ?', published_at).order('published_at ASC').first
  end

  def previous
    Post.published.where('published_at < ?', published_at).order('published_at DESC').first
  end
end
