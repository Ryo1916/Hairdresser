# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id                :bigint(8)        not null, primary key
#  title             :string
#  body              :text
#  slug              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  author_id         :integer
#  published         :boolean          default(FALSE)
#  published_at      :datetime
#  impressions_count :integer          default(0)
#

class Post < ApplicationRecord
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  # acts_as_punchable
  is_impressionable counter_cache: true # to get the count of impressions

  # association
  belongs_to :author

  # validations
  validates_presence_of :title
  validates_presence_of :body

  # scopes
  scope :published, -> { where(published: true) }
  scope :descending_order, -> { order(created_at: :desc) }
  scope :recent_paginated_post, lambda { |page|
    descending_order.paginate(
      page: page,
      per_page: Constants::MAX_DISPLAY_POSTS_NUM_FOR_TOP_PAGE
    )
  }
  scope :paginated_post, lambda { |page|
    descending_order.paginate(
      page: page,
      per_page: Constants::MAX_DISPLAY_POSTS_NUM_FOR_INDEX_PAGE
    )
  }
  scope :with_tag, ->(tag) { tagged_with(tag) if tag.present? }
  scope :list_for_top_page, lambda { |page, tag|
    recent_paginated_post(page).with_tag(tag)
  }
  scope :list_for_authors_index_page, lambda { |page, tag|
    paginated_post(page).with_tag(tag)
  }

  # Friendly ID gem
  extend FriendlyId
  friendly_id :title, use: :slugged

  # replace any white space chars to "-" to use japanese
  def normalize_friendly_id(string)
    string.gsub(/\s+/, '-')
  end

  def should_generate_new_friendly_id?
    title_changed?
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
