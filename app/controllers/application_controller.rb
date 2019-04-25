# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'author'

  private

  def after_sign_in_path_for(resource)
    authors_posts_path(resource)
  end

  def after_update_path_for(resource)
    edit_author_registration_path(resource)
  end

  def after_sign_out_path_for(_resource)
    new_author_session_path
  end
end
