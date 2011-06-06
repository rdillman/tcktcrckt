# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{linecache}
  s.version = "0.43"

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.authors = [%q{R. Bernstein}]
  s.cert_chain = nil
  s.date = %q{2008-06-11}
  s.description = %q{LineCache is a module for reading and caching lines. This may be useful for example in a debugger where the same lines are shown many times.}
  s.email = %q{rockyb@rubyforge.net}
  s.extensions = [%q{ext/extconf.rb}]
  s.extra_rdoc_files = [%q{README}, %q{lib/linecache.rb}, %q{lib/tracelines.rb}]
  s.files = [%q{README}, %q{lib/linecache.rb}, %q{lib/tracelines.rb}, %q{ext/extconf.rb}]
  s.homepage = %q{http://rubyforge.org/projects/rocky-hacks/linecache}
  s.require_paths = [%q{lib}]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.2")
  s.rubyforge_project = %q{rocky-hacks}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Read file with caching}

  if s.respond_to? :specification_version then
    s.specification_version = 1

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
