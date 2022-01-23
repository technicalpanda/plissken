# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "plissken/version"

Gem::Specification.new do |spec|
  spec.authors = ["Dave Hrycyszyn", "Stuart Chinery"]
  spec.description = "Have you ever needed to automatically convert JSON-style camelBack or CamelCase hash keys into "\
                     "more Rubyish snake_case?\n\nPlissken to the rescue.\n\nThis gem recursively converts all "\
                     "camelBack or CamelCase keys in a hash structure to snake_case."
  spec.email = ["dave@constructiveproof.com", "code@technicalpanda.co.uk"]
  spec.files = Dir["lib/**/*", "MIT-LICENSE", "Rakefile", "README.md", "VERSION"]
  spec.homepage = "https://github.com/technicalpanda/plissken"
  spec.metadata["rubygems_mfa_required"] = "true"
  spec.name = "plissken"
  spec.required_ruby_version = ">= 2.7"
  spec.summary = "Snakify your camel keys when working with JSON APIs"
  spec.version = Plissken::VERSION
  spec.license = "MIT"

  spec.add_development_dependency "byebug", "~> 11.1"
  spec.add_development_dependency "minitest", "~> 5.14"
  spec.add_development_dependency "minitest-fail-fast", "~> 0.1"
  spec.add_development_dependency "minitest-macos-notification", "~> 0.3"
  spec.add_development_dependency "minitest-reporters", "~> 1.4"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rubocop", "~> 1.7"
  spec.add_development_dependency "rubocop-minitest", "~> 0.10"
  spec.add_development_dependency "rubocop-rake", "~> 0.5"
end
