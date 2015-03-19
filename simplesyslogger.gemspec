# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simplesyslogger/version'

Gem::Specification.new do |spec|
  spec.name          = "simplesyslogger"
  spec.version       = Simplesyslogger::VERSION
  spec.authors       = ["Fritz G. Batroni"]
  spec.email         = ["fritz.g.batroni@gmail.com"]
  spec.summary       = %q{A really simple syslogging utility based on syslogger gem}
  spec.description   = %q{A really simple syslogging utility based on syslogger gem}
  spec.homepage      = "http://github.com/fbatroni/simplesyslogger"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "shoulda", ">= 0"
  spec.add_development_dependency "rake"
end