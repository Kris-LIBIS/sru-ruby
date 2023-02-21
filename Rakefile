# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task default: :spec

require 'rubygems'
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rake'
require 'yard'

Bundler::GemHelper.install_tasks

YARD::Rake::YardocTask.new('doc') do |t|
  t.files = ['lib/**/*.rb', 'README']
end

