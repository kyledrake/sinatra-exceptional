# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sinatra/exceptional/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = [
    "Kyle Drake",
    "Hrvoje Šimić"
  ]

  gem.email         = [
    "kyledrake@gmail.com",
    "shime.ferovac@gmail.com"
  ]

  gem.description   = %q{Sinatra adapter for use with exceptional}
  gem.summary       = %q{Sinatra adapter for use with exceptional, in case you need it}
  gem.homepage      = ""

  gem.files         =  Dir["Gemfile","LICENSE","README.md","Rakefile","lib/**/*","sinatra-exceptional.gemspec","spec/*.rb"]
  gem.test_files    =  Dir["spec/*.rb"]
  gem.name          = "sinatra-exceptional"
  gem.require_paths = ["lib/**/*"]
  gem.version       = Sinatra::Exceptional::VERSION
  gem.add_dependency 'exceptional'
  gem.add_dependency 'sinatra'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'json_pure'
  gem.add_development_dependency 'pry'
end
