# frozen_string_literal: true

require_relative "lib/newcomb/version"

Gem::Specification.new do |spec|
  spec.name = "newcomb"
  spec.summary = "Generate natural random numbers"
  spec.description = "Generate random numbers that adhere to Benford's Law"
  spec.version = Newcomb::VERSION

  spec.author = "Steve Richert"
  spec.email = "steve.richert@hey.com"
  spec.license = "MIT"
  spec.homepage = "https://github.com/laserlemon/newcomb"

  spec.metadata = {
    "allowed_push_host" => "https://rubygems.org",
    "bug_tracker_uri" => "https://github.com/laserlemon/newcomb/issues",
    "funding_uri" => "https://github.com/sponsors/laserlemon",
    "homepage_uri" => "https://github.com/laserlemon/newcomb",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/laserlemon/newcomb",
  }

  spec.required_ruby_version = ">= 3.0.0"
  spec.add_development_dependency "bundler", ">= 2"
  spec.add_development_dependency "rake", ">= 13"

  spec.files = [
    "lib/newcomb.rb",
    "lib/newcomb/version.rb",
    "LICENSE.txt",
    "newcomb.gemspec",
  ]

  spec.extra_rdoc_files = ["README.md"]
end
