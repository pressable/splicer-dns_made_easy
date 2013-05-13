# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'splicer/dns_made_easy/version'

Gem::Specification.new do |spec|
  spec.name          = "splicer-dns_made_easy"
  spec.version       = Splicer::DnsMadeEasy::VERSION
  spec.authors       = ["Matthew Johnston"]
  spec.email         = ["warmwaffles@gmail.com"]
  spec.description   = %q{The splicer adapter for interacting DnsMadeEasy}
  spec.summary       = %q{The splicer adapter for interacting DnsMadeEasy}
  spec.homepage      = "https://github.com/zippykid/dns_made_easy"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency('splicer', '~> 1.1')
  spec.add_dependency('rest-client')

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
