# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'optimadmin_generators/version'

Gem::Specification.new do |spec|
  spec.name          = 'optimadmin_generators'
  spec.version       = OptimadminGenerators::VERSION
  spec.authors       = ['James Doyley', 'Paul Lonsdale']
  spec.email         = ['james@optimised.today', 'paul@optimised.today']

  spec.summary       = 'Generators to be used with optimadmin.'
  # spec.description   = %q{Write a longer description or delete this line.}
  spec.homepage      = 'http://optimised.today'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #  raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # spec.add_dependency 'rails'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 11.0'
  spec.add_development_dependency 'rails'
end
