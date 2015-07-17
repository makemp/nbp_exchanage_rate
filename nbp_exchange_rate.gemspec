# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nbp/version'

Gem::Specification.new do |spec|
  spec.name          = 'nbp_exchange_rate'
  spec.version       = NBP::VERSION
  spec.authors       = ['Maciej Kempin']

  spec.summary       = %(Handles Polish National Bank exchange rate API)
  spec.license       = 'MIT'

  spec.files         = %w(lib/nbp_exchange_rate.rb lib/nbp/exchange_rate.rb lib/nbp/version.rb lib/nbp/xml_file_list.rb
                          lib/nbp/commons.rb)
  spec.require_paths = %w(lib)

  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '>= 0.28.0'
  spec.add_development_dependency 'webmock', '>= 1.21'
  spec.add_development_dependency 'rspec-its', '>= 1.2.0'
  spec.add_runtime_dependency 'nori', '>= 2.4.0'
end
