class Post < ApplicationRecord

  # association
  belongs_to :author

  # Friendly ID gem
  extend FriendlyId
  friendly_id :title, use: :slugged

  # most_recent as if order method
  scope :most_recent, -> { order(id: :desc) }

  def should_generate_new_friendly_id?
    title_changed?
  end

  def display_day_published
    "Published #{created_at.strftime('%-b %-d, %Y')}"
  end
end
