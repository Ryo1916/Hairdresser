# frozen_string_literal: true

# == Schema Information
#
# Table name: images
#
#  id         :bigint(8)        not null, primary key
#  alt        :string(255)
#  hint       :string(255)
#  file       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Image < ApplicationRecord
  mount_uploader :file, ImageUploader
end
