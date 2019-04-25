# frozen_string_literal: true

module Authors
  class TagsController < ApplicationController
    include Common

    before_action :set_tags, only: %i[index]

    def index
      @tag = ActsAsTaggableOn::Tag.new
    end

    def create
      @tag = ActsAsTaggableOn::Tag.new(tag_params)
      respond_to do |format|
        if @tag.save(tag_params)
          format.html { redirect_to authors_tags_path, notice: 'Tag was successfully created.' }
          format.json { render :index, status: :ok }
        else
          format.html { render :index }
          format.json { render json: @tag.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @tag = ActsAsTaggableOn::Tag.find(params[:id])
      @tag.destroy
      respond_to do |format|
        format.html { redirect_to authors_tags_path, notice: 'Tag was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def tag_params
      params.require(:acts_as_taggable_on_tag).permit(:name)
    end
  end
end
