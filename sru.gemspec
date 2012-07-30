spec = Gem::Specification.new do |s|
  s.name = 'sru'
  s.version = '0.0.9'
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
  s.add_development_dependency 'bundler', '>= 1.1.4'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'redcarpet'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'yard'
end
