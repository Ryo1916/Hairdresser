# frozen_string_literal: true

# == Schema Information
#
# Table name: authors
#
#  id                     :bigint(8)        not null, primary key
#  name                   :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Author < ApplicationRecord
  # callbacks
  before_save { email.downcase! }

  # Include default devise modules. Others available are:
  # :registerable, :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # association
  has_many :posts

  # validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates_presence_of :name, uniqueness: true, length: { maximum: 50 }
  validates_presence_of :email, length: { maximum: 255 },
                                format: { with: VALID_EMAIL_REGEX },
                                uniqueness: { case_sensitive: false }
end
