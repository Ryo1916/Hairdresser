# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale

  layout :set_layout

  private

  def set_layout
    author_signed_in? ? 'author' : 'blog'
  end

  def after_sign_in_path_for(resource)
    authors_posts_path(resource)
  end

  def after_sign_out_path_for(_resource)
    new_author_session_path
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale
    I18n.locale = locale_in_params || locale_in_accept_language || I18n.default_locale
  end

  def locale_in_params
    params[:locale].present? ? params[:locale].to_sym.presence_in(I18n.available_locales) : nil
  end

  def locale_in_accept_language
    http_accept_language.compatible_language_from(I18n.available_locales)
  end
end
