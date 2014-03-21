# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sweet_params/version'

Gem::Specification.new do |spec|
  spec.name          = 'sweet_params'
  spec.version       = SweetParams::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ['Evgeny Likholetov']
  spec.email         = ['bsboris@gmail.com']
  spec.description   = 'Syntax sugar for Rails Strong Parameters.'
  spec.summary       = 'Syntax sugar for Rails Strong Parameters.'
  spec.homepage      = 'https://github.com/bsboris/sweet_params'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^test/})
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '>= 4.0'
  spec.add_dependency 'actionpack', '>= 4.0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'minitest', '~> 4.2'
  spec.add_development_dependency 'rake'
end
