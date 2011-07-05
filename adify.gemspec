# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{adify}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Eric Harrison"]
  s.date = %q{2011-07-05}
  s.description = %q{Adify lets you create ad tags easily and quickly with a simple common structure}
  s.email = %q{eharrison@classifiedadventures.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    ".rvmrc",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "adify.gemspec",
    "lib/adify.rb",
    "lib/adify/controller.rb",
    "lib/adify/helper.rb",
    "lib/adify/model.rb",
    "lib/generators/adify/USAGE",
    "lib/generators/adify/templates/_dfp.html.erb",
    "lib/generators/adify_generator.rb",
    "spec/adify_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/fuelxc/adify}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.1}
  s.summary = %q{create ad tags for common ad servers easily.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 2.3.5"])
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3.5"])
      s.add_runtime_dependency(%q<activerecord>, [">= 2.3.5"])
      s.add_runtime_dependency(%q<actionpack>, [">= 2.3.5"])
      s.add_development_dependency(%q<rspec-rails>, ["~> 2.3.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<ruby-debug>, [">= 0"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 2.3.5"])
      s.add_dependency(%q<activesupport>, [">= 2.3.5"])
      s.add_dependency(%q<activerecord>, [">= 2.3.5"])
      s.add_dependency(%q<actionpack>, [">= 2.3.5"])
      s.add_dependency(%q<rspec-rails>, ["~> 2.3.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.0"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<ruby-debug>, [">= 0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 2.3.5"])
    s.add_dependency(%q<activesupport>, [">= 2.3.5"])
    s.add_dependency(%q<activerecord>, [">= 2.3.5"])
    s.add_dependency(%q<actionpack>, [">= 2.3.5"])
    s.add_dependency(%q<rspec-rails>, ["~> 2.3.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.0"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<ruby-debug>, [">= 0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
  end
end

