# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rbx-require-relative}
  s.version = "0.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{R. Bernstein}]
  s.date = %q{2011-06-10}
  s.description = %q{Ruby 1.9's require_relative for Rubinius and MRI 1.8. 

We also add abs_path which is like __FILE__ but __FILE__ can be fooled
by a sneaky "chdir" while abs_path can't. 

If you are running on Ruby 1.9.2, require_relative is the pre-defined
version.  The benefit we provide in this situation by this package is
the ability to write the same require_relative sequence in Rubinius
1.8 and Ruby 1.9.
}
  s.email = %q{rockyb@rubyforge.net}
  s.homepage = %q{http://github.com/rocky/rbx-require-relative}
  s.licenses = [%q{MIT}]
  s.rdoc_options = [%q{--title}, %q{require_relative 0.0.5 Documentation}]
  s.require_paths = [%q{lib}]
  s.required_ruby_version = Gem::Requirement.new("~> 1.8.7")
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Ruby 1.9's require_relative for Rubinius and MRI 1.8.   We also add abs_path which is like __FILE__ but __FILE__ can be fooled by a sneaky "chdir" while abs_path can't.   If you are running on Ruby 1.9.2, require_relative is the pre-defined version.  The benefit we provide in this situation by this package is the ability to write the same require_relative sequence in Rubinius 1.8 and Ruby 1.9.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
