# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ladder_converter/version'

Gem::Specification.new do |spec|
  spec.name          = "ladder_converter"
  spec.version       = LadderConverter::VERSION
  spec.authors       = ["Katsuyoshi Ito"]
  spec.email         = ["kito@itosoft.com"]

  spec.summary       = %q{The Ladder converter is to convert a ladder program of PLC to another maker. }
  spec.description   = %q{The Ladder converter converts a PLC ladder program to another maker. Now we are trying to convert MITSUBISHI PLCs to Keyence PLCs.}
  spec.homepage      = "https://github.com/ito-soft-design/ladder_converter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib", "lib/ladder_converter"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "csv"
  spec.add_development_dependency "test-unit"
end
