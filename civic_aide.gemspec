# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'civic_aide/version'

Gem::Specification.new do |spec|
  spec.name          = "civic_aide"
  spec.version       = CivicAide::VERSION
  spec.authors       = ["Tyler Pearson"]
  spec.email         = ["ty.pearson@gmail.com"]
  spec.summary       = %q{A Ruby wrapper to interact with the Google Civic Information API}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/tylerpearson/civic_aide"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 10.1.1"
  spec.add_development_dependency "rspec", "~> 2.14.1"
  spec.add_development_dependency "vcr", '~> 2.5.0'
  spec.add_development_dependency "webmock", '1.13.0'

  spec.add_runtime_dependency "httparty"
  spec.add_runtime_dependency "hashie"
end
