# -*- coding: utf-8; mode: ruby  -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'checkable/version'

Gem::Specification.new do |gem|
  gem.name          = "checkable"
  gem.version       = Checkable::VERSION
  gem.authors       = ["Conan Dalton"]
  gem.license       = "MIT"
  gem.email         = ["conan@conandalton.net"]
  gem.summary       = %q{A simple runner for checks, kind of like unit tests for user data, for cases where Rails validations won't cut the mustard. }
  gem.description   = %q{Runs a set of "checks" against your objects and lets you know what passes and what fails. Use the report as a basis for proposing fixes to your users. }
  gem.homepage      = "https://github.com/conanite/checkable"

  gem.add_development_dependency 'rspec', '~> 2.9'
  gem.add_development_dependency 'rspec_numbering_formatter'

  gem.files         = `git ls-files -z`.split("\x0")
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
