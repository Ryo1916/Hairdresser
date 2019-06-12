# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'full_title' do
    it 'returns only base_title' do
      expect(helper.full_page_title).to eq(Constants::APP_NAME)
    end

    it 'returns base_title with page_title' do
      page_title = 'Posts'
      expect(helper.full_page_title(page_title: page_title))
        .to eq("#{page_title} | #{Constants::APP_NAME}")
    end
  end
end
