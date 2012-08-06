# -*- encoding: utf-8 -*-
require File.expand_path('../lib/blastbeat/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Roberto De Ioris"]
  gem.email         = ["roberto@unbit.it"]
  gem.description   = %q{BlastBeat Server integration module}
  gem.summary       = %q{BlastBeat Server integration module}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "blastbeat"
  gem.require_paths = ["lib"]
  gem.version       = Blastbeat::VERSION

  gem.add_dependency("ffi-rzmq")
end
