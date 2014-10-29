# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'moveflat/version'

Gem::Specification.new do |spec|
  spec.name          = "moveflat"
  spec.version       = Moveflat::VERSION
  spec.authors       = ["Alessandro"]
  spec.email         = ["hello@alssnd.ro"]
  spec.summary       = %q{Scrape accommodation info from Moveflat.com}
  spec.description   = %q{Scrape accommodation info from Moveflat.com}
  spec.homepage      = "https://github.com/alssndro/moveflat"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1.0"
  spec.add_development_dependency "fakeweb", "~> 1.3.0"
  spec.add_development_dependency "pry", "~> 0.10.1"
  spec.add_development_dependency "guard", "~> 2.7.0"
  spec.add_development_dependency "guard-rspec", "~> 4.3.1"

  spec.add_dependency 'nokogiri', "~> 1.6.3.1"
end
