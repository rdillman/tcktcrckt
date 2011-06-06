# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{chronic}
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Tom Preston-Werner}]
  s.date = %q{2010-10-22}
  s.description = %q{Chronic is a natural language date/time parser written in pure Ruby.}
  s.email = %q{tom@mojombo.com}
  s.extra_rdoc_files = [%q{README.md}, %q{HISTORY.md}, %q{LICENSE}]
  s.files = [%q{README.md}, %q{HISTORY.md}, %q{LICENSE}]
  s.homepage = %q{http://github.com/mojombo/chronic}
  s.rdoc_options = [%q{--charset=UTF-8}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{chronic}
  s.rubygems_version = %q{1.8.3}
  s.summary = %q{Natural language date/time parsing.}

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
