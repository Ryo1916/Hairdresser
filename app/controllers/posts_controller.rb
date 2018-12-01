class PostsController < InheritedResources::Base

  private

    def post_params
      params.require(:post).permit(:title, :body, :description, :slug)
    end
end

