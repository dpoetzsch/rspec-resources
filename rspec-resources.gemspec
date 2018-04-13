
# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec/resources/version'

Gem::Specification.new do |spec|
  spec.name          = 'rspec-resources'
  spec.version       = RSpec::Resources::VERSION
  spec.authors       = ['David Poetzsch-Heffter']
  spec.email         = ['davidpoetzsch@web.de']

  spec.summary       = 'A concise DSL for testing rails resources with rspec'
  # spec.description   = 'TODO: Write a longer description or delete this line.'
  spec.homepage      = 'https://github.com/dpoetzsch/rspec-resources'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  s.add_runtime_dependency 'rspec', '~> 3.0'
  s.add_runtime_dependency 'activesupport', '>= 3.0.0'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rspec'
end
