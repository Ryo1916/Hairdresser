# frozen_string_literal: true

module Blog
  class PostsController < BlogController
    before_action :set_author, only: %i[index show]

    def index
      @posts = Post.published.list_for_blog(params[:page], params[:tag])
    end

    def show
      @post = Post.friendly.find(params[:id])
      @post.published ? @post : redirect_to(posts_path)
    end

    private

    def set_author
      @author = current_author
    end
  end
end
