# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pomelo_client/version'

Gem::Specification.new do |spec|
  spec.name          = "pomelo_client"
  spec.version       = PomeloClient::VERSION
  spec.authors       = ["hzh"]
  spec.email         = ["sforce1000@gmail.com"]
  spec.summary       = %q{pomelo client for ruby}
  spec.description   = %q{pomelo client for ruby.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"

  spec.add_dependency 'socketio-client'
  spec.add_dependency 'json'
end
