#!/usr/bin/env ruby

require 'rubygems'
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end
require 'rake'
require 'rake/testtask'
require 'yard'

Bundler::GemHelper.install_tasks

task :default => [:test]

Rake::TestTask.new('test') do |t|
  t.libs << 'lib'
  t.pattern = 'test/*_test.rb'
  t.verbose = true
  t.ruby_opts = ['-r sru', '-r test/unit']
end

YARD::Rake::YardocTask.new('doc') do |t|
  t.files = ['lib/**/*.rb', 'README']
end

