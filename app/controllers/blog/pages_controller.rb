# frozen_string_literal: true

module Blog
  class PagesController < BlogController
    MAX_DISPLAY_NUMBER_OF_CATEGORIES = 6

    def top
      @posts = Post.published.list_for_top(params[:page], params[:tag])
      @author = Author.first
      @tags = ActsAsTaggableOn::Tag.order(id: :ASC).limit(MAX_DISPLAY_NUMBER_OF_CATEGORIES)
    end
  end
end
