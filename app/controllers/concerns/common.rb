# frozen_string_literal: true

module Common
  extend ActiveSupport::Concern

  def set_author
    @author = current_author
  end

  def set_tags
    @tags = ActsAsTaggableOn::Tag.all
  end
end
