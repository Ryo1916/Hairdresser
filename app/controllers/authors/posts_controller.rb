# frozen_string_literal: true

module Authors
  class PostsController < AuthorController
    include Common

    before_action :set_post, only: %i[show edit update destroy publish unpublish]
    before_action :set_author, only: %i[index show new edit]
    before_action :set_tags, only: %i[new edit]

    def index
      @posts = current_author.posts.search_post(params[:title_or_body]).list_for_index_page(params[:page], params[:tag])
    end

    def show; end

    def new
      @post = current_author.posts.new
    end

    def edit; end

    # POST /posts/1/publish
    def publish
      @post.publish
      redirect_to authors_posts_path
    end

    # POST /posts/1/unpublish
    def unpublish
      @post.unpublish
      redirect_to authors_posts_path
    end

    def create
      @post = current_author.posts.new(post_params)
      respond_to do |format|
        if @post.save
          format.html { redirect_to authors_post_path(@post), notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to authors_post_path(@post), notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @post.destroy
      respond_to do |format|
        format.html { redirect_to authors_posts_path, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def set_post
      @post = current_author.posts.friendly.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :slug, tag_list: [])
    end
  end
end
