# frozen_string_literal: true

module Authors
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_account_update_params, only: %i[update]
    before_action :first_author_registered?, only: %i[new create]

    def update
      super
    end

    private

    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

    def after_update_path_for(resource)
      authors_posts_path(resource)
    end

    def first_author_registered?
      return unless Author.count == 1

      if author_signed_in?
        redirect_to root_path
      else
        redirect_to new_author_session_path
      end
    end
  end
end
