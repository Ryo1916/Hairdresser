# frozen_string_literal: true

module Blog
  class PostsController < BlogController
    include Common

    before_action :set_author, only: %i[index show]
    before_action :set_most_views, only: %i[index show]

    def index
      @posts = Post.published.list_for_blog(params[:page], params[:tag])
    end

    def show
      @post = Post.friendly.find(params[:id])
      @post.published ? @post : redirect_to(posts_path, flash: { alert: 'This post is not published.' })
      @post.punch(request)
    end

    private

    MAX_DISPLAY_NUMBER_OF_MOST_VIEWED = 10

    def set_most_views
      @most_views = Post.most_hit.limit(MAX_DISPLAY_NUMBER_OF_MOST_VIEWED)
    end
  end
end
