# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "adify/version"

Gem::Specification.new do |s|
  s.name        = "adify"
  s.version     = Adify::VERSION
  s.authors     = ["Eric Harrison"]
  s.email       = ["eric@rubynooby.com"]
  s.homepage    = "http://www.rubynooby.com"
  s.summary = %q{create ad tags for common ad servers easily.}
  s.description = %q{Adify lets you create ad tags easily and quickly with a simple common structure}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency "ruby-debug19"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rails"
  s.add_development_dependency "sqlite3"
end
