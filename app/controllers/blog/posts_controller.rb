module Blog
  class PostsController < BlogController
    before_action :set_post, only: [:show]

    # GET /posts
    # GET /posts.json
    def index
      @posts = Post.most_recent
    end

    # GET /posts/1
    # GET /posts/1.json
    def show
    end


    private

      def set_post
        @post = Post.friendly.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:title, :body, :description, :slug, :banner_image_url)
      end
  end

end
