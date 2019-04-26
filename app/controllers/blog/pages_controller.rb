# frozen_string_literal: true

module Blog
  class PagesController < BlogController
    def top
      @posts = Post.published.list_for_top(params[:page], params[:tag])
      @author = Author.first
      @tags = ActsAsTaggableOn::Tag.order(id: :ASC).limit(6)
    end
  end
end
