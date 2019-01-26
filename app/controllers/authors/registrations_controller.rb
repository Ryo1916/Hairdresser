# frozen_string_literal: true

module Authors
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_account_update_params, only: [:update]

    def update
      super
    end

    private

    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

    def after_update_path_for(resource)
      edit_user_registration_path(resource)
    end
  end
end
