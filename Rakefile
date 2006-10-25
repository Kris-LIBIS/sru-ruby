RUBY_OAI_VERSION = '0.0.3'

require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/packagetask'
require 'rake/gempackagetask'

task :default => [:test]

Rake::TestTask.new('test') do |t|
  t.libs << 'lib'
  t.pattern = 'test/*_test.rb'
  t.verbose = true
  t.ruby_opts = ['-r sru', '-r test/unit']
end

spec = Gem::Specification.new do |s|
    s.name = 'sru'
    s.version = '0.0.3'
    s.author = 'Ed Summers'
    s.email = 'ehs@pobox.com'
    s.homepage = 'http://www.textualize.com/sruby'
    s.platform = Gem::Platform::RUBY
    s.summary = 'a Ruby library for Search and Retrieve by URL'
    s.files = Dir.glob("{lib,test}/**/*")
    s.require_path = 'lib'
    s.autorequire = 'sru'
    s.has_rdoc = true
end

if $0 == __FILE__
    Gem::manage_gems
    Gem::Builder.new(spec).build
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end
