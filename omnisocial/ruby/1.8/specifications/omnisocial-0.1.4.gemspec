# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{omnisocial}
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Tim Riley}]
  s.date = %q{2010-11-29}
  s.description = %q{Twitter and Facebook logins for your Rails application.}
  s.email = %q{tim@openmonkey.com}
  s.homepage = %q{http://github.com/icelab/omnisocial}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.3}
  s.summary = %q{Twitter and Facebook logins for your Rails application.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<oa-core>, ["~> 0.1.2"])
      s.add_runtime_dependency(%q<oa-oauth>, ["~> 0.1.2"])
      s.add_runtime_dependency(%q<bcrypt-ruby>, ["~> 2.1"])
    else
      s.add_dependency(%q<oa-core>, ["~> 0.1.2"])
      s.add_dependency(%q<oa-oauth>, ["~> 0.1.2"])
      s.add_dependency(%q<bcrypt-ruby>, ["~> 2.1"])
    end
  else
    s.add_dependency(%q<oa-core>, ["~> 0.1.2"])
    s.add_dependency(%q<oa-oauth>, ["~> 0.1.2"])
    s.add_dependency(%q<bcrypt-ruby>, ["~> 2.1"])
  end
end
