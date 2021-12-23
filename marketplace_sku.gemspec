Gem::Specification.new do |s|
  s.name               = "marketplace_sku"
  s.version            = "1.0.0"
  s.default_executable = "marketplace_sku"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Julia Rose"]
  s.date = %q{2020-04-20}
  s.description = %q{Gem for parsing marketplace.tf SKUs}
  s.email = %q{nick@quaran.to}
  s.files = ["Rakefile", "lib/parse.rb", "bin/marketplace_sku"]
  s.test_files = ["test/test_hola.rb"]
  s.homepage = %q{http://rubygems.org/gems/hola}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Hola!}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
