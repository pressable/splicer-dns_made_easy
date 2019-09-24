# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'splicer/dns_made_easy/version'

Gem::Specification.new do |spec|
  spec.name          = 'splicer-dns_made_easy'
  spec.version       = Splicer::DnsMadeEasy::VERSION
  spec.authors       = ['Matthew Johnston', 'Joshua Stowers', 'Oliver Garcia']
  spec.email         = %w{warmwaffles@gmail.com joshua@pressable.com oliver@pressable.com}
  spec.description   = %q{The Splicer adapter for interacting DnsMadeEasy}
  spec.summary       = %q{Use this gem together with Splicer if you are using multiple DNS providers, and want a unified interface to manage each of them simultaneously}
  spec.homepage      = 'https://github.com/pressable/splicer-dns_made_easy'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w{lib}

  spec.add_dependency('rest-client')
  spec.add_dependency('splicer')

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
