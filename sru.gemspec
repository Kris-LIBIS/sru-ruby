require 'rubygems'
spec = Gem::Specification.new do |s|
    s.name = 'sru'
    s.version = '0.0.2'
    s.author = 'Ed Summers'
    s.email = 'ehs@pobox.com'
    s.homepage = 'http://www.textualize.com/sruby'
    s.platform = Gem::Platform::RUBY
    s.summary = 'talk to sru servers with ruby'
    s.files = Dir.glob("{lib,test}/**/*")
    s.require_path = 'lib'
    s.autorequire = 'sru'
    s.has_rdoc = true
    s.test_file = 'test.rb'
end

if $0 == __FILE__
    Gem::manage_gems
    Gem::Builder.new(spec).build
end

