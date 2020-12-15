
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rspec/become_matcher/version"

Gem::Specification.new do |spec|
  spec.name          = "rspec-become-matcher"
  spec.version       = Rspec::BecomeMatcher::VERSION
  spec.authors       = ["Daisuke Fujimura"]
  spec.email         = ["me@fujimuradaisuke.com"]

  spec.summary       = %q{RSpec matcher to check that an expression changed its result in arbitrary seconds.}
  spec.description   = %q{RSpec matcher to check that an expression changed its result in arbitrary seconds. Useful for expecting value which changes asynchronously.}
  spec.homepage      = "https://github.com/fujimura/rspec-become-matcher"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency     "rspec-expectations", ">= 3"

  spec.add_development_dependency "bundler", "> 2"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-expectations", ">= 3"
end
