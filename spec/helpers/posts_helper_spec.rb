# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagsHelper, type: :helper do
  let!(:author) { create(:author) }
  let!(:post) { create(:post, author: author) }
  let!(:posts) { create_list(:post, 5, author: author) }
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
        .to eq(post.published_at.strftime('%Y %-b %-d'))
    end

    it "returns 'Not published yet.'" do
      expect(helper.display_day_published(post: post))
        .to eq('Not published yet.')
    end
  end

  describe 'sort_by_title' do
    xit 'orders ascending by title' do
      expect(helper.sort_by_title(posts: posts)).to eq(Post.order(title: :asc))
    end

    xit 'orders descending by title' do
      expect(helper.sort_by_title(posts: posts)).to eq(Post.order(title: :desc))
    end
  end

  describe 'sort_by_pv' do
    xit 'returns posts that ordered ascending by pv' do
      expect(helper.sort_by_pv(posts: posts)).to eq(Post.order(impressions_count: :asc))
    end

    xit 'returns posts that ordered descending by pv' do
      expect(helper.sort_by_pv(posts: posts)).to eq(Post.order(impressions_count: :desc))
    end
  end

  describe 'sort_by_created_at' do
    xit 'returns posts that ordered ascending by created date' do
      expect(helper.sort_by_created_at(posts: posts)).to eq(Post.order(created_at: :asc))
    end

    xit 'returns posts that ordered descending by created date' do
      expect(helper.sort_by_created_at(posts: posts)).to eq(Post.order(created_at: :desc))
    end
  end

  describe 'sort_by_published_at' do
    xit 'returns posts that ordered ascending by published date' do
      expect(helper.sort_by_created_at(posts: posts)).to eq(Post.order(published_at: :asc))
    end

    xit 'returns posts that ordered descending by published date' do
      expect(helper.sort_by_created_at(posts: posts)).to eq(Post.order(published_at: :desc))
    end
  end
end
