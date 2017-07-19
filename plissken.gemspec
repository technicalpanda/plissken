$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "plissken/version"

Gem::Specification.new do |s|
  s.name        = "plissken"
  s.version     = Plissken::VERSION
  s.authors     = ["Dave Hrycyszyn", "Michael Chrisco", "Stuart Chinery"]
  s.email       = ["dhrycyszyn@zonedigital.com"]
  s.homepage    = "https://github.com/futurechimp/plissken"
  s.summary     = "Snakify your camel keys when working with JSON APIs"
  s.description = "Have you ever needed to automatically convert JSON-style camelBack or CamelCase hash keys into more Rubyish snake_case?\n\nPlissken to the rescue.\n\nThis gem recursively converts all camelBack or CamelCase keys in a hash structure to snake_case."
  s.license     = "MIT"

  s.files = Dir[
    "lib/**/*",
    "MIT-LICENSE",
    "Rakefile",
    "README.md",
    "VERSION"
  ]

  s.add_development_dependency "minitest", "~> 3.0"
  s.add_development_dependency "minitest-reporters", "~> 0.14"
  s.add_development_dependency "rake", "~> 12.0"
end
