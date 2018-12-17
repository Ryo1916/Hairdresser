module Blog
  class PostsController < BlogController

    # GET /posts
    # GET /posts.json
    def index
      @posts = Post.published.list_for(params[:page], params[:tag])
    end

    # GET /posts/1
    # GET /posts/1.json
    def show
      @post = Post.friendly.find(params[:id])
      @post.published ? @post : redirect_to(posts_path)
    end

  end

end
