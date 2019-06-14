# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id                :bigint(8)        not null, primary key
#  title             :string
#  body              :text
#  slug              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  author_id         :integer
#  published         :boolean          default(FALSE)
#  published_at      :datetime
#  impressions_count :integer          default(0)
#

require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:author) { create(:author) }
  let!(:post) { create(:post, author: author, impressions_count: 2) }
  let!(:posts) { create_list(:post, 5, author: author) }

  PAGINATED_QUERY = 2
  EXISTING_TAG = 'cut'
  UNEXISTING_TAG = 'unexisting_tag'
  EMPTY_TAG = ''

  describe 'associations' do
    it { should belong_to(:author).class_name('Author') }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end

  describe 'scopes' do
    context 'published' do
      it 'returns published posts' do
        posts.map(&:publish)
        expect(Post.published).to eq(Post.where(published: true))
      end

      it 'returns no posts when all posts are unpublished' do
        expect(Post.published).to be_empty
      end
    end

    context 'descending_order' do
      it 'returns descending ordered posts' do
        expect(Post.descending_order).to eq(Post.order(created_at: :desc))
      end
    end

    context 'impressions_count_order' do
      it 'returns posts ordered by impressions counts' do
        post.publish
        expect(Post.impressions_count_order).to eq(Post.order(impressions_count: :desc))
      end
    end

    context 'recent_paginated_post' do
      it 'returns paginated posts for top page' do
        expect(Post.recent_paginated_post(PAGINATED_QUERY))
          .to eq(Post.descending_order.paginate(page: PAGINATED_QUERY, per_page: Constants::MAX_DISPLAY_POSTS_NUM_FOR_TOP_PAGE))
      end
    end

    context 'paginated_post' do
      it 'returns paginated posts for index page' do
        expect(Post.paginated_post(PAGINATED_QUERY))
          .to eq(Post.descending_order.paginate(page: PAGINATED_QUERY, per_page: Constants::MAX_DISPLAY_POSTS_NUM_FOR_INDEX_PAGE))
      end
    end

    context 'with_tag' do
      it 'returns posts with the specified tag' do
        expect(Post.with_tag(EXISTING_TAG)).to eq(Post.tagged_with(EXISTING_TAG))
      end

      it "returns no post when the specified tag doesn't exist" do
        expect(Post.with_tag(UNEXISTING_TAG)).to be_empty
      end

      it 'returns all posts' do
        expect(Post.with_tag(EMPTY_TAG)).to eq(Post.all)
      end
    end

    context 'list_for_top_page' do
      it 'returns posts for top page' do
        expect(Post.list_for_top_page(PAGINATED_QUERY, EMPTY_TAG))
          .to eq(Post.recent_paginated_post(PAGINATED_QUERY).with_tag(EMPTY_TAG))
      end

      it 'returns posts for top with the specified tag' do
        expect(Post.list_for_top_page(PAGINATED_QUERY, EXISTING_TAG))
          .to eq(Post.recent_paginated_post(PAGINATED_QUERY).with_tag(EXISTING_TAG))
      end

      it "returns no post when the specified tag doesn't exist" do
        expect(Post.list_for_top_page(PAGINATED_QUERY, UNEXISTING_TAG))
          .to eq(Post.recent_paginated_post(PAGINATED_QUERY).with_tag(UNEXISTING_TAG))
      end
    end

    context 'list_for_authors_index_page' do
      it 'returns posts for authors index page' do
        expect(Post.list_for_authors_index_page(PAGINATED_QUERY, EMPTY_TAG))
          .to eq(Post.paginated_post(PAGINATED_QUERY).with_tag(EMPTY_TAG))
      end

      it 'returns posts for authors index page with the specified tag' do
        expect(Post.list_for_authors_index_page(PAGINATED_QUERY, EXISTING_TAG))
          .to eq(Post.paginated_post(PAGINATED_QUERY).with_tag(EXISTING_TAG))
      end

      it "returns no post when the specified tag doesn't exist" do
        expect(Post.list_for_authors_index_page(PAGINATED_QUERY, UNEXISTING_TAG))
          .to eq(Post.paginated_post(PAGINATED_QUERY).with_tag(UNEXISTING_TAG))
      end
    end

    context 'set_popular_posts' do
      it 'returns an impressionable post' do
        post.publish
        expect(Post.set_popular_posts)
          .to eq(Post.published.where('impressions_count > ?', Constants::NOT_VIEWD_POSTS).impressions_count_order.limit(Constants::MAX_DISPLAY_NUM_FOR_MOST_VIEWED_POSTS))
      end

      it 'returns no post' do
        expect(Post.set_popular_posts).to be_empty
      end
    end
  end

  describe 'for publishing methods' do
    context 'publish' do
      it 'updates publishing status to true' do
        post.publish
        expect(post.published).to be_truthy
      end
    end

    context 'unpublished' do
      it 'updates publishing status to false' do
        post.publish
        post.unpublish
        expect(post.published).to be_falsey
      end
    end

    context 'next' do
      it 'returns next post' do
        posts.map(&:publish)
        expect(posts.first.next).to eq(posts.second)
      end

      it 'returns no post' do
        posts.map(&:publish)
        expect(posts.last.next).to be_nil
      end
    end

    context 'previous' do
      it 'returns previous post' do
        posts.map(&:publish)
        expect(posts.second.previous).to eq(posts.first)
      end

      it 'returns no post' do
        posts.map(&:publish)
        expect(posts.first.previous).to be_nil
      end
    end
  end
end
