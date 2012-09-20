# -*- encoding: utf-8 -*-
require File.expand_path('../lib/norma19/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Fernando Guillen"]
  gem.email         = ["fguillen.mail@gmail.com"]
  gem.description   = "Norma19 file generator"
  gem.summary       = "Norma19 file generator"
  gem.homepage      = ""

  gem.add_development_dependency "mocha"
  gem.add_development_dependency "delorean"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "norma19"
  gem.require_paths = ["lib"]
  gem.version       = Norma19::VERSION
end
