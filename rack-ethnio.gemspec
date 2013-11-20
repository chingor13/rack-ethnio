Gem::Specification.new do |s|
  s.name = "rack-ethnio"
  s.version = "0.0.1"
  s.description = "Integrate Ethnio tracking into your Rack-based application"
  s.summary = "Integrate Ethnio tracking into your Rack-based application"
  s.add_dependency "rack"

  s.add_development_dependency "rack-test"
  s.add_development_dependency "nokogiri"
  s.add_development_dependency "mocha"

  s.author = "Jeff Ching"
  s.email = "jeff@chingr.com"
  s.homepage = "http://github.com/chingor13/rack-ethnio"
  s.license = "MIT"

  s.files = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
end
