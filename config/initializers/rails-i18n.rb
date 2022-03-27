# set i18n load path
Rails.application.config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

# set the languages available on this website
Rails.application.config.i18n.available_locales = %i(ja en)

# throw an error if different language is specified
Rails.application.config.i18n.enforce_available_locales = true

# set default launguage
Rails.application.config.i18n.default_locale = :ja
