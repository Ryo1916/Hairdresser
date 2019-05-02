# frozen_string_literal: true

module Authors
  class ImagesController < ApplicationController
    before_action :set_image, only: %i[edit update_default_image destroy]

    def index
      @image = Image.new
      @images = Image.order(created_at: :desc)
    end

    def edit; end

    def create
      @image = Image.new(image_params)
      respond_to do |format|
        if @image.save
          format.html { redirect_to authors_images_path, notice: 'Image was successfully created.' }
          format.json { render :index, status: :created }
        else
          format.html { render :index }
          format.json { render json: @image.errors, status: :unprocessable_entity }
        end
      end
    end

    def update_default_img
      @default_image = Image.find_by(hint: 'default')
      @default_image.hint = ''
      @image.hint = 'default'
      respond_to do |format|
        if @default_image.update(image_params) && @image.update(image_params)
          format.html { redirect_to authors_images_path, notice: 'Default image was successfully changed.' }
          format.json { render :index, status: :ok }
        else
          format.html { render :index }
          format.json { render json: @image.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @image.destroy
      respond_to do |format|
        format.html { redirect_to authors_images_path, notice: 'Image was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def set_image
      @image = Image.find(params[:id])
    end

    def image_params
      params.require(:image).permit(:alt, :hint, :file)
    end
  end
end
