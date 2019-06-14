# frozen_string_literal: true

# == Schema Information
#
# Table name: authors
#
#  id                     :bigint(8)        not null, primary key
#  name                   :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'rails_helper'

RSpec.describe Author, type: :model do
  let!(:author) { create(:author) }

  after(:each) do
    I18n.locale = :en
  end

  describe 'associations' do
    it { should have_many(:posts).class_name('Post') }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
  end

  describe 'valid author' do
    it 'has a valid factory' do
      expect(author).to be_valid
    end

    it 'has a valid email with entered by uppercase' do
      valid_author = build(:author, name: 'uppercase', email: 'LIKEUPCASE@TEST.ABC')
      expect(valid_author).to be_valid
    end
  end

  describe 'invalid author' do
    it 'has no name' do
      invalid_author = build(:author, name: nil)
      invalid_author.valid?
      expect(invalid_author.errors[:name]).to include("can't be blank")
    end

    it 'has no email' do
      invalid_author = build(:author, email: nil)
      invalid_author.valid?
      expect(invalid_author.errors[:email]).to include("can't be blank")
    end

    it 'has no password' do
      invalid_author = build(:author, password: nil)
      invalid_author.valid?
      expect(invalid_author.errors[:password]).to include("can't be blank")
    end

    it 'has a duplicated name' do
      invalid_author = build(:author, name: 'testuser')
      invalid_author.valid?
      expect(invalid_author.errors[:name]).to include('has already been taken')
    end

    it 'has a too long name' do
      EXCEEDED_MAX_LENGTH = 51
      invalid_author = build(:author, name: 'a' * EXCEEDED_MAX_LENGTH)
      invalid_author.valid?
      expect(invalid_author.errors[:name]).to include('is too long (maximum is 50 characters)')
    end

    it 'has invalid email format' do
      invalid_author = build(:author, email: 'test@test.')
      invalid_author.valid?
      expect(invalid_author.errors[:email]).to include('is invalid')
    end

    it 'has duplicated email' do
      invalid_author = build(:author, email: 'test@test.abc')
      invalid_author.valid?
      expect(invalid_author.errors[:email]).to include('has already been taken')
    end
  end
end
