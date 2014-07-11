# coding: utf-8

Gem::Specification.new do |spec|
  spec.name    = "newcomb"
  spec.version = "0.0.1"

  spec.author      = "Steve Richert"
  spec.email       = "steve.richert@gmail.com"
  spec.summary     = "Generate natural random numbers"
  spec.description = "Generate random numbers that adhere to Benford's Law"
  spec.homepage    = "https://github.com/laserlemon/newcomb"
  spec.license     = "MIT"

  spec.files      = `git ls-files -z`.split("\x0")
  spec.test_files = spec.files.grep(/^spec/)

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.3"
end
