# frozen_string_literal: true

class AuthorController < ApplicationController
  before_action :authenticate_author!
end
