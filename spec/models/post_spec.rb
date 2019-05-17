# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:post) { create(:post) }
  let!(:posts) { create_list(:post, 5) }

  # validations test
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
end
