$LOAD_PATH.unshift File.expand_path(__dir__)
$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'rspec'
require 'simplecov'
SimpleCov.start

require 'omniauth'
require 'omniauth-patreon'

RSpec.configure do |config|
  config.extend OmniAuth::Test::StrategyMacros, type: :strategy
end
