# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'styoe/version'

Gem::Specification.new do |spec|
  spec.name          = "styoe"
  spec.version       = Styoe::VERSION
  spec.authors       = ["Antonio Scandurra"]
  spec.email         = ["as-cii@outlook.com"]
  spec.description   = %q{Start your engines.}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/as-cii/styoe"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0.0.beta2"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "aruba"
end
