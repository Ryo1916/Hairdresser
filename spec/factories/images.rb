# frozen_string_literal: true

# == Schema Information
#
# Table name: images
#
#  id         :bigint(8)        not null, primary key
#  alt        :string
#  hint       :string
#  file       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :image do
    alt { 'just the default image.' }
    hint { 'default' }
    file { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/default.jpg'), 'image/jpeg') }
  end
end
