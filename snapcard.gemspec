Gem::Specification.new do |s|
  s.name          = "snapcard"
  s.version       = "1.0.0"
  s.authors       = ["Jordan Luyke"]
  s.email         = ["support@snapcard.io"]
  s.summary       = "Client library for Snapcard API"
  s.description   = "Client library for Snapcard API"
  s.homepage      = "https://www.snapcard.io/"
  s.license       = "MIT"

  s.files         = Dir["{spec,lib}/**/*"] + %w(LICENSE README.md)
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end
