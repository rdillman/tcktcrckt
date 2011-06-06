# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{geokit}
  s.version = "1.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Andre Lewis}]
  s.date = %q{2009-09-21}
  s.description = %q{}
  s.email = [%q{andre@earthcode.com}]
  s.extra_rdoc_files = [%q{History.txt}, %q{Manifest.txt}]
  s.files = [%q{History.txt}, %q{Manifest.txt}]
  s.rdoc_options = [%q{--main}, %q{README.txt}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{geokit}
  s.rubygems_version = %q{1.8.3}
  s.summary = %q{Geokit provides geocoding and distance calculation in an easy-to-use API}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe>, [">= 1.12.2"])
    else
      s.add_dependency(%q<hoe>, [">= 1.12.2"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.12.2"])
  end
end
