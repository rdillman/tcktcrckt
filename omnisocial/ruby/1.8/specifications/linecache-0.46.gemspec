# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{linecache}
  s.version = "0.46"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{R. Bernstein}]
  s.date = %q{2011-06-19}
  s.description = %q{LineCache is a module for reading and caching lines. This may be useful for
example in a debugger where the same lines are shown many times.
}
  s.email = %q{rockyb@rubyforge.net}
  s.extensions = [%q{ext/extconf.rb}]
  s.extra_rdoc_files = [%q{README}, %q{lib/linecache.rb}, %q{lib/tracelines.rb}]
  s.files = [%q{README}, %q{lib/linecache.rb}, %q{lib/tracelines.rb}, %q{ext/extconf.rb}]
  s.homepage = %q{http://rubyforge.org/projects/rocky-hacks/linecache}
  s.require_paths = [%q{lib}]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubyforge_project = %q{rocky-hacks}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Read file with caching}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rbx-require-relative>, ["> 0.0.4"])
    else
      s.add_dependency(%q<rbx-require-relative>, ["> 0.0.4"])
    end
  else
    s.add_dependency(%q<rbx-require-relative>, ["> 0.0.4"])
  end
end
