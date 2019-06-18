# frozen_string_literal: true

module Blog
  class PostsController < BlogController
    include Common

    before_action :set_author, only: %i[index show]
    before_action :set_popular_posts, only: %i[index show]

    impressionist actions: %i[show]

    def index
      @posts = Post.published.list_for_index_page(params[:page], params[:tag])
    end

    def show
      @post = Post.friendly.find(params[:id])
      @post.published ? @post : redirect_to(posts_path, flash: { alert: 'This post is not published.' })
      impressionist(@post, nil, unique: [:session_hash])
    end

    private

    def set_popular_posts
      @popular_posts = Post.popular_posts
    end
  end
end
