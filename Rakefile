# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "plissken"
  gem.homepage = "http://github.com/futurechimp/plissken"
  gem.license = "MIT"
  gem.summary = %Q{Snakify your camel keys when working with JSON APIs}
  gem.description = %Q{
    Have you ever needed to automatically convert JSON-style camelBack or
    CamelCase hash keys into more Rubyish snake_case?

    Plissken to the rescue.

    This gem recursively converts all camelBack or CamelCase keys in a hash
    structure to snake_case.
  }
  gem.email = "dave.hrycyszyn@headlondon.com"
  gem.authors = ["Dave Hrycyszyn"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "plissken #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
