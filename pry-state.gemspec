# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pry-state/version'

Gem::Specification.new do |spec|
  spec.name          = "pry-state"
  spec.version       = PryState::VERSION
  spec.authors       = ["Sudhagar"]
  spec.email         = ["sudhagar@isudhagar.in"]
  spec.summary       = 'Shows the state in Pry Session'
  spec.description   = 'Pry state lets you to see the values of the instance and local variables in a pry session'
  spec.homepage      = "https://github.com/SudhagarS/pry-state"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec', '~> 3.3', '>= 3.3.0'
  spec.add_development_dependency 'rspec-core', '~> 3.3', '>= 3.3.2'
  spec.add_development_dependency 'pry-nav', '~> 0.2.4'
  spec.add_development_dependency 'guard', '~> 2.13', '>= 2.13.0'
  spec.add_development_dependency 'guard-rspec', '~> 4.6', '>= 4.6.3'
  spec.add_runtime_dependency 'pry', '>= 0.9.10', '< 0.11.0'

end
