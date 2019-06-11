# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagsHelper, type: :helper do
  let!(:author) { create(:author) }
  let!(:post) { create(:post, author: author) }
  let!(:post_with_image) { create(:post, author: author, body: "<img src=\'/uploads/image/file/2/default.jpeg\'/>") }
  let!(:image) { create(:image) }

  describe 'parsing_img' do
    it 'returns the default image' do
      expect(helper.parsing_img(text: post.body))
        .to match('/uploads/image/file/1/')
    end

    it 'returns the uploaded image' do
      expect(helper.parsing_img(text: post_with_image.body))
        .to match('/uploads/image/file/2')
    end
  end

  describe 'display_day_published' do
    it 'returns published day' do
      post.publish
      expect(helper.display_day_published(post: post))
        .to eq("Published #{post.published_at.strftime('%-b %-d, %Y')}")
    end

    it "returns 'Not published yet.'" do
      expect(helper.display_day_published(post: post))
        .to eq('Not published yet.')
    end
  end
end
