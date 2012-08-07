RUBY_SRU_VERSION = '0.0.9'

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

Rake::RDocTask.new('doc') do |rd|
  rd.rdoc_files.include('lib/**/*.rb', 'README')
  rd.main = 'README'
  rd.options << "--inline-source"
  rd.rdoc_dir = 'doc'
end

spec = Gem::Specification.new do |s|
  s.name = 'sru'
  s.version = RUBY_SRU_VERSION
  s.author = 'Ed Summers'
  s.email = 'ehs@pobox.com'
  s.homepage = 'http://github.com/edsu/sru-ruby'
  s.platform = Gem::Platform::RUBY
  s.summary = 'a Ruby library for the Search/Retrieve via URL (SRU) protocol'
  s.description = <<-EOF
Client for the Search/Retrieve via URL (SRU) protocol.
http://www.loc.gov/standards/sru/
EOF
  s.files = Dir.glob("{lib,test}/**/*")
  s.require_path = 'lib'
  s.has_rdoc = true
  s.add_dependency 'libxml-ruby'
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end
