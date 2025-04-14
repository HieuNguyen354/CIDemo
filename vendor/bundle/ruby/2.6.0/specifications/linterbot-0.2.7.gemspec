# -*- encoding: utf-8 -*-
# stub: linterbot 0.2.7 ruby lib

Gem::Specification.new do |s|
  s.name = "linterbot".freeze
  s.version = "0.2.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Guido Marucci Blas".freeze]
  s.bindir = "exe".freeze
  s.date = "2017-04-18"
  s.description = "\n    A bot that parses swiftlint output and analyzes a GitHub pull request.\n    Then for each linter violation it will make comment in the pull request diff on the\n    line where the violation was made.\n  ".freeze
  s.email = ["guidomb@gmail.com".freeze]
  s.executables = ["linterbot".freeze]
  s.files = ["exe/linterbot".freeze]
  s.homepage = "https://github.com/guidomb/linterbot".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.3".freeze
  s.summary = "A bot that parses swiftlint output and analyzes a GitHub pull request.".freeze

  s.installed_by_version = "3.2.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.11"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_development_dependency(%q<pry-byebug>.freeze, ["~> 3.3"])
    s.add_runtime_dependency(%q<octokit>.freeze, ["~> 4.2"])
    s.add_runtime_dependency(%q<commander>.freeze, ["~> 4.3"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.11"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<pry-byebug>.freeze, ["~> 3.3"])
    s.add_dependency(%q<octokit>.freeze, ["~> 4.2"])
    s.add_dependency(%q<commander>.freeze, ["~> 4.3"])
  end
end
