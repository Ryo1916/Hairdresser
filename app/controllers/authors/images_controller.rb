# frozen_string_literal: true

module Authors
  class ImagesController < ApplicationController
    def new
      @image = Image.build.params(image_params)
    end

    def show
      @image = Image.find(params[:id])
    end

    private

    def image_params
      params.require(:image).permit(:alt, :hint, :file)
    end
  end
end
