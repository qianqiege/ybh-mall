require_relative 'boot'

require 'rails/all'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module YBHMall
  class Application < Rails::Application
        config.to_prepare do
      # Load application's model / class decorators
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # load carrierware files
    config.autoload_paths += Dir["#{Rails.root}/app/uploaders"]
    config.autoload_paths << Rails.root.join('lib')
    config.time_zone = 'Beijing'
    config.i18n.default_locale = :'zh-CN'
    config.assets.paths << "#{Rails.root}/app/assets/videos"

    config.paths.add File.join('app', 'services'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir["#{Rails.root}/app/services/*"]
  end
end
