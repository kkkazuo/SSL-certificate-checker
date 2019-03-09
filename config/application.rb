require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_record/railtie"
require "active_job/railtie"
require "action_controller/railtie"

Bundler.require(*Rails.groups)

module SSLCertificateChecker
  class Application < Rails::Application
    config.load_defaults 5.2
    config.api_only = true
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.autoload_paths += %W(#{config.root}/lib)
    config.enable_dependency_loading = true
  end
end
