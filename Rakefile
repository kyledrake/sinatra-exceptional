#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'rake/testtask'

# To run tests in the order of a seed: bundle exec rake test TESTOPTS="--seed=987"
Rake::TestTask.new do |t|
  t.pattern = "spec/**/*_spec.rb"
end

task :default => :test
