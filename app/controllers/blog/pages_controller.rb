module Blog
  class PagesController < BlogController
    def top
      @posts = Post.published.list_for_top(params[:page], params[:tag])
    end
    
  end
end
