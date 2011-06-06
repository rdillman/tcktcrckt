# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ruby-debug-base}
  s.version = "0.10.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Kent Sibilev}]
  s.date = %q{2010-10-26}
  s.description = %q{ruby-debug is a fast implementation of the standard Ruby debugger debug.rb.
It is implemented by utilizing a new Ruby C API hook. The core component 
provides support that front-ends can build on. It provides breakpoint 
handling, bindings for stack frames among other things.
}
  s.email = %q{ksibilev@yahoo.com}
  s.extensions = [%q{ext/extconf.rb}]
  s.extra_rdoc_files = [%q{README}, %q{ext/ruby_debug.c}]
  s.files = [%q{README}, %q{ext/ruby_debug.c}, %q{ext/extconf.rb}]
  s.homepage = %q{http://rubyforge.org/projects/ruby-debug/}
  s.require_paths = [%q{lib}]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.2")
  s.rubyforge_project = %q{ruby-debug}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Fast Ruby debugger - core component}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<linecache>, [">= 0.3"])
    else
      s.add_dependency(%q<linecache>, [">= 0.3"])
    end
  else
    s.add_dependency(%q<linecache>, [">= 0.3"])
  end
end
