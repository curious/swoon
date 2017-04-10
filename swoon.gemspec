# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'swoon/version'

Gem::Specification.new do |spec|
  spec.name          = "swoon"
  spec.version       = Swoon::VERSION
  spec.authors       = ["Josh Deeden"]
  spec.email         = ["jdeeden@gmail.com"]

  spec.summary       = %q{SendWithUs API Ruby Wrapper}
  spec.description   = %q{An unofficial ruby client for the SendWithUs API}
  spec.homepage      = "https://github.com/curious_com/swoon"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client"
  spec.add_dependency "virtus", "~> 1.0.5"
  spec.add_dependency "representable", "~> 3.0.2"
  spec.add_dependency "multi_json", ">= 1.11.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
