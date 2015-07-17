$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'nbp_exchange_rate'
require 'webmock'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow: %w( localhost 127.0.0.1 0.0.0.0))
require 'rspec/its'
require_relative 'stub_responses/nbp_exchange_rate_fetch'
