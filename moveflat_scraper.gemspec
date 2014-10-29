# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'moveflat_scraper/version'

Gem::Specification.new do |spec|
  spec.name          = "moveflat_scraper"
  spec.version       = MoveflatScraper::VERSION
  spec.authors       = ["Alessandro"]
  spec.email         = ["hello@alssnd.ro"]
  spec.summary       = %q{Scrape accommodation info from Moveflat.com}
  spec.description   = %q{Scrape accommodation info from Moveflat.com}
  spec.homepage      = "https://github.com/alssndro/moveflat_scraper"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
end
