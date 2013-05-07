require 'active_support/configurable'

module ApiEngine
  # Configures global settings for ApiEngine
  #   ApiEngine.configure do |config|
  #     config.whitelist = [:post]
  #   end

  def self.configure(&block)
    yield config
  end

  # Global settings for ApiEngine
  def self.config
    @config ||= ApiEngine::Configuration.new
  end

  class Configuration #:nodoc:
    include ActiveSupport::Configurable
    config_accessor(:models) { false }
  end

end