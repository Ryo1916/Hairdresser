# frozen_string_literal: true

module Blog
  class PagesController < BlogController
    def top
      @posts = Post.published.list_for_top(params[:page], params[:tag])
      @author = Author.first
      @tags = ActsAsTaggableOn::Tag.order(id: :ASC).limit(Constants::MAX_DISPLAY_CATEGORIES_NUM_FOR_TOP_PAGE)
    end
  end
end
