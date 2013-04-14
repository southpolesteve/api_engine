module ApiEngine
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      desc <<DESC
Description:
    Copies api_engine configuration file to your application's initializer directory.
DESC

      def copy_config_file
        template 'api_engine_config.rb', 'config/initializers/api_engine.rb'
      end
    end
  end
end