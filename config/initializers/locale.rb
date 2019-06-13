# frozen_string_literal: true

# set locales files path
I18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}')]

# set available locales as whitelist
I18n.available_locales = %i[en ja]

# change default locale to japanese
I18n.default_locale = :ja
