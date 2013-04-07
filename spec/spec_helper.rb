ENV['RAILS_ENV'] ||= 'test'

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'rspec/rails'
require 'factory_girl_rails'
require 'database_cleaner'

Rails.backtrace_cleaner.remove_silencers!
# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = "random"
  config.use_transactional_fixtures = false

  DatabaseCleaner.strategy = :truncation

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end