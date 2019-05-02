# frozen_string_literal: true

module Blog
  class PostsController < BlogController
    include Common

    before_action :set_author, only: %i[index show]

    def index
      @posts = Post.published.list_for_blog(params[:page], params[:tag])
    end

    def show
      @post = Post.friendly.find(params[:id])
      @post.published ? @post : redirect_to(posts_path, flash: { alert: 'This post is not published.' })
      @post.punch(request)
    end
  end
end
