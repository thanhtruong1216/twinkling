require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Photogram
  class Application < Rails::Application
    config.load_defaults 6.0
    I18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]
    I18n.available_locales = [:en, :vi]
    I18n.default_locale = :en
    config.generators do |g|
      g.test_framework :rspec,
        :fixtures => true,
        :view_specs => false,
        :helper_specs => false,
        :routing_specs => false,
        :controller_specs => true,
        :request_specs => true
      g.fixture_replacement :factory_bot, :dir => 'spec/factories'
    end
  end
end
