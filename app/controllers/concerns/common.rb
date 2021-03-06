# frozen_string_literal: true

module Common
  extend ActiveSupport::Concern

  def set_author
    @author = current_author
  end

  def set_tags
    @tags = ActsAsTaggableOn::Tag.order(taggings_count: :desc)
  end
end
