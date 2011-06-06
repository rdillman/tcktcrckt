# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{net-ldap}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Francis Cianfrocca}, %q{Emiel van de Laar}, %q{Rory O'Connell}, %q{Kaspar Schiess}, %q{Austin Ziegler}]
  s.date = %q{2010-03-17}
  s.description = %q{Pure Ruby LDAP library.}
  s.email = [%q{blackhedd@rubyforge.org}, %q{gemiel@gmail.com}, %q{rory.ocon@gmail.com}, %q{kaspar.schiess@absurd.li}, %q{austin@rubyforge.org}]
  s.extra_rdoc_files = [%q{History.txt}, %q{Manifest.txt}, %q{README.txt}]
  s.files = [%q{History.txt}, %q{Manifest.txt}, %q{README.txt}]
  s.homepage = %q{http://net-ldap.rubyforge.org/}
  s.rdoc_options = [%q{--main}, %q{README.txt}]
  s.require_paths = [%q{lib}]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubyforge_project = %q{net-ldap}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Pure Ruby LDAP support library with most client features and some server features.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rubyforge>, [">= 2.0.4"])
      s.add_development_dependency(%q<gemcutter>, [">= 0.5.0"])
      s.add_development_dependency(%q<archive-tar-minitar>, ["~> 0.5.1"])
      s.add_development_dependency(%q<hanna>, ["~> 0.1.2"])
      s.add_development_dependency(%q<hoe-git>, ["~> 1"])
      s.add_development_dependency(%q<hoe>, [">= 2.5.0"])
    else
      s.add_dependency(%q<rubyforge>, [">= 2.0.4"])
      s.add_dependency(%q<gemcutter>, [">= 0.5.0"])
      s.add_dependency(%q<archive-tar-minitar>, ["~> 0.5.1"])
      s.add_dependency(%q<hanna>, ["~> 0.1.2"])
      s.add_dependency(%q<hoe-git>, ["~> 1"])
      s.add_dependency(%q<hoe>, [">= 2.5.0"])
    end
  else
    s.add_dependency(%q<rubyforge>, [">= 2.0.4"])
    s.add_dependency(%q<gemcutter>, [">= 0.5.0"])
    s.add_dependency(%q<archive-tar-minitar>, ["~> 0.5.1"])
    s.add_dependency(%q<hanna>, ["~> 0.1.2"])
    s.add_dependency(%q<hoe-git>, ["~> 1"])
    s.add_dependency(%q<hoe>, [">= 2.5.0"])
  end
end
