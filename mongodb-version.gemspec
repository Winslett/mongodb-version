# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongodb/version/version'

Gem::Specification.new do |spec|
  spec.name          = "mongodb-version"
  spec.version       = MongoDB::Version::VERSION
  spec.authors       = ["Chris Winslett"]
  spec.email         = ["chris@mongohq.com"]
  spec.description   = %q{An easy gem to use to ask questions about MongoDB versions}
  spec.summary       = %q{You ask, it answers.  If it is not answering properly, just submit a pull request :)}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry-debugger"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-bundler"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
