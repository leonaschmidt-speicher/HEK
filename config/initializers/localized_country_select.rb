# Require the plugin code
require 'localized_country_select/localized_country_select.rb'

# Load locales for countries from +locale+ directory into Rails
I18n.load_path += Dir[ File.join(File.dirname(__FILE__), 'locale', '*.{rb,yml}') ]
