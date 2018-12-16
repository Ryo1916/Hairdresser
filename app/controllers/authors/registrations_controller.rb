module Authors
  class RegistrationsController < Devise::RegistrationsController
    def update
      super
    end

    private

      def after_update_path_for(resource)
        edit_user_registration_path(resource)
      end

  end
end
