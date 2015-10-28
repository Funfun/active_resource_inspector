# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_resource_inspector/version'

Gem::Specification.new do |spec|
  spec.name          = "active_resource_inspector"
  spec.version       = ActiveResourceInspector::VERSION
  spec.authors       = ["Tsyren Ochirov"]
  spec.email         = ["nsu1team@gmail.com"]

  spec.summary       = %q{Allows you to inpsect your project's ActiveResource entities.}
  spec.description   = %q{Allows you to inpsect your project's ActiveResource entities.}
  spec.homepage      = "https://github.com/Funfun/active_resource_inspector"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'activesupport', '~> 2.0', '>= 2.0.0'

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "activeresource", '~> 4.0', '>= 4.0.0'
end
